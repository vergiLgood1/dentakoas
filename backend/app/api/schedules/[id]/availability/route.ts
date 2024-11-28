import { NextResponse } from "next/server";
import db from "@/lib/db";

export async function GET(
  req: Request,
  { params }: { params: { id: string } }
) {
  const { searchParams } = new URL(req.url);
  const scheduleId = searchParams.get("id") || params.id;

  try {
    // Fetch the schedule with related post and timeslots
    const schedule = await db.schedule.findUnique({
      where: { id: scheduleId },
      include: {
        post: true, // Include the related Post to get requiredParticipant
        timeslot: true,
      },
    });

    if (!schedule) {
      return NextResponse.json(
        { error: "Schedule not found." },
        { status: 404 }
      );
    }

    const { dateStart, dateEnd, timeslot, post } = schedule;

    // Fetch total confirmed participants for the post
    const currentParticipants = await db.appointment.count({
      where: {
        scheduleId,
        status: "Confirmed", // Only count confirmed participants
        AND: {
          schedule: {
            postId: post.id,
          },
        },
      },
    });

    // Generate all dates within the dateStart and dateEnd range
    const dates = [];
    let currentDate = new Date(dateStart);
    while (currentDate <= new Date(dateEnd)) {
      dates.push(new Date(currentDate));
      currentDate.setDate(currentDate.getDate() + 1);
    }

    // Check availability for each timeslot and date
    const availability = await Promise.all(
      dates.map(async (date) => {
        const dateString = date.toISOString().split("T")[0]; // Format as YYYY-MM-DD

        const timeslotAvailability = await Promise.all(
          timeslot.map(async (slot) => {
            // Count confirmed participants for each timeslot
            const participants = await db.appointment.count({
              where: {
                scheduleId,
                timeslotId: slot.id,
                date: new Date(dateString),
                status: "Confirmed", // Only count confirmed participants
                AND: {
                  schedule: {
                    timeslot: {
                      some: {
                        id: slot.id,
                      },
                    },
                  },
                },
              },
            });

            // Check if requiredParticipants has been reached
            const isFullyBooked =
              participants >= (post.requiredParticipant ?? 0);

            return {
              timeslotId: slot.id,
              startTime: slot.startTime,
              endTime: slot.endTime,
              date: dateString,
              maxParticipants: slot.maxParticipants,
              currentParticipants: participants,
              isAvailable:
                !isFullyBooked && participants < (slot.maxParticipants ?? 0),
            };
          })
        );

        return {
          date: dateString,
          timeslots: timeslotAvailability,
        };
      })
    );

    return NextResponse.json({
      status: "Success",
      message: "Schedule availability retrieved successfully.",
      data: {
        requiredParticipants: post.requiredParticipant,
        currentParticipants,
        availability,
      },
    });
  } catch (error) {
    console.error("Error checking schedule availability:", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
