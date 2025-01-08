import db from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET(
  req: Request,
  props: { params: Promise<{ id: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const id = searchParams.get("id") || params.id;

  if (!id) {
    return NextResponse.json(
      { error: "ID parameter is required" },
      { status: 400 }
    );
  }

  try {
    const schedule = await db.schedule.findUnique({
      where: { id },
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

    if (!schedule) {
      return NextResponse.json(
        { error: "Schedule not found" },
        { status: 404 }
      );
    }

    return NextResponse.json(
      {
        schedule,
      },
      { status: 200 }   
    );
  } catch (error) {
    console.error("Error fetching Schedule", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
