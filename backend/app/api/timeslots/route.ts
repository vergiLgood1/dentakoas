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

// export async function POST(req: Request) {
//   const body = await req.json();

//   const { scheduleId, startTime, endTime, maxParticipants } = body;

//   console.log("received body", body);

//   if (!scheduleId || !startTime || !endTime || !maxParticipants) {
//     console.log("Missing required fields");
//     return NextResponse.json(
//       { error: "Missing required fields" },
//       { status: 400 }
//     );
//   }

//   try {
//     const schedule = await db.schedule.findUnique({
//       where: { id: scheduleId },
//       select: { id: true },
//     });

//     if (!schedule) {
//       console.log("Schedule not found");
//       return NextResponse.json(
//         { error: "Schedule not found." },
//         { status: 404 }
//       );
//     }

//     // Validasi format HH:mm
//     const timeFormat = /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/;
//     if (!timeFormat.test(startTime) || !timeFormat.test(endTime)) {
//       console.log("Invalid time format");
//       return NextResponse.json(
//         { error: "Invalid time format. Use HH:mm." },
//         { status: 400 }
//       );
//     }

//     const timeslot = await db.timeslot.createMany({
//       data: {
//         scheduleId,
//         startTime,
//         endTime,
//         maxParticipants,
//       },
//       skipDuplicates: true,
//     });

//     console.log("Timeslot created successfully", timeslot);

//     return NextResponse.json(
//       {
//         status: "Success",
//         message: "Timeslots created successfully",
//         data: { timeslot },
//       },
//       { status: 200 }
//     );
//   } catch (error) {
//     console.error("Error creating Timeslots", error);
//     return NextResponse.json(
//       { error: "Internal Server Error" },
//       { status: 500 }
//     );
//   }
// }

export async function POST(req: Request) {
  const body = await req.json();

  if (!body.scheduleId || !body.timeslots || !Array.isArray(body.timeslots)) {
    return NextResponse.json(
      { error: "Invalid request format" },
      { status: 400 }
    );
  }

  const { scheduleId, timeslots } = body;

  console.log("received body", body);

  try {
    // Validasi scheduleId
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

    // Validasi dan proses timeslots
    const validTimeslots = timeslots.filter(
      (slot: {
        scheduleId: string;
        startTime: string;
        endTime: string;
        maxParticipants: number;
      }) => {
        const timeFormat = /^([0-1]?[0-9]|2[0-3]):[0-5][0-9]$/;
        return (
          slot.scheduleId === scheduleId &&
          timeFormat.test(slot.startTime) &&
          timeFormat.test(slot.endTime) &&
          slot.maxParticipants
        );
      }
    );

    if (validTimeslots.length === 0) {
      return NextResponse.json(
        { error: "No valid timeslots provided." },
        { status: 400 }
      );
    }

    // Simpan ke database
    const createdTimeslots = await db.timeslot.createMany({
      data: validTimeslots,
      skipDuplicates: true,
    });

    return NextResponse.json(
      {
        status: "Success",
        message: "Timeslots created successfully",
        data: createdTimeslots,
      },
      { status: 201 }
    );
  } catch (error) {
    console.error("Error creating Timeslots", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
