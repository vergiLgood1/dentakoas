import db from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET(req: Request) {
  const searchParams = new URL(req.url);

  try {
    const shedules = await db.schedule.findMany({
      include: {
        timeslot: {
          select: {
            id: true,
            startTime: true,
            endTime: true,
            maxParticipants: true,
            currentParticipants: true,
            isAvailable: true,
          },
        },
        Appointment: true,
      },
    });

    if (!shedules) {
      return NextResponse.json(
        { error: "Schedules not found" },
        { status: 404 }
      );
    }

    return NextResponse.json(
      {
        status: "Success",
        message: "Schedules retrieved successfully",
        data: { schedules: shedules },
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error fetching Schedules", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}

export async function POST(req: Request) {
  const body = await req.json();

  const { postId, dateStart, dateEnd } = body;

  try {
    const post = await db.post.findUnique({
      where: { id: postId },
      select: { id: true },
    });

    if (!post) {
      return NextResponse.json({ error: "Post not found." }, { status: 404 });
    }

    const schedule = await db.schedule.create({
      data: {
        dateStart: new Date(dateStart),
        dateEnd: new Date(dateEnd),
        post: {
          connect: {
            id: postId,
          },
        },
      },
    });

    return NextResponse.json(
      {
        schedule,
      },
      { status: 201 }
    );
  } catch (error) {
    console.error("Error creating Schedule", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
