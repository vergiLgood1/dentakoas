import db from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);

  try {
    const timeslots = await db.timeslot.findMany({});

    if (!timeslots) {
      return NextResponse.json(
        { error: "Timeslots not found" },
        { status: 404 }
      );
    }

    return NextResponse.json(
      {
        status: "Success",
        message: "Timeslots retrieved successfully",
        data: { timeslots: timeslots },
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error fetching Timeslots", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}

export async function POST(req: Request) {
  const body = await req.json();

  const { scheduleId, startTime, endTime, maxParticipants } = body;

  if (!scheduleId || !startTime || !endTime || !maxParticipants) {
    return NextResponse.json(
      { error: "Missing required fields" },
      { status: 400 }
    );
  }

  try {
    const schedule = await db.schedule.findUnique({
      where: { id: scheduleId },
      select: { id: true },
    });

    if (!schedule) {
      return NextResponse.json(
        { error: "Schedule not found." },
        { status: 404 }
      );
    }

    // Validasi format HH:mm
    const timeFormat = /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/;
    if (!timeFormat.test(startTime) || !timeFormat.test(endTime)) {
      return NextResponse.json(
        { error: "Invalid time format. Use HH:mm." },
        { status: 400 }
      );
    }

    const timeslot = await db.timeslot.create({
      data: {
        startTime,
        endTime,
        maxParticipants,
        schedule: {
          connect: {
            id: scheduleId,
          },
        },
      },
    });

    return NextResponse.json(
      {
        status: "Success",
        message: "Timeslots retrieved successfully",
        data: { timeslot },
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error fetching Timeslots", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
