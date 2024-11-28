import db from "@/lib/db";
import { Prisma } from "@prisma/client";
import { NextResponse } from "next/server";

export async function GET(
  req: Request,
  { params }: { params: { id: string } }
) {
  const { searchParams } = new URL(req.url);
  const id = searchParams.get("id") || params.id;

  try {
    const timeslot = await db.timeslot.findUnique({
      where: {
        id,
      } as Prisma.TimeslotWhereUniqueInput,
    });

    if (!timeslot) {
      return NextResponse.json(
        { error: "Timeslot not found" },
        { status: 404 }
      );
    }

    return NextResponse.json(
      {
        status: "Success",
        message: "Get spesific timeslot successfully",
        data: { timeslot },
      },
      { status: 200 }
    );
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error: "An error occurred while fetching the timeslot" },
      { status: 500 }
    );
  }
}

export async function PATCH(
  req: Request,
  { params }: { params: { id: string } }
) {
  const { searchParams } = new URL(req.url);
  const id = searchParams.get("id") || params.id;

  const body = await req.json();
  const { startTime, endTime, maxParticipants, currentParticipants, isAvailable } = body;

  try {
    const existingTimeslot = await db.timeslot.findUnique({
      where: {
        id,
      } as Prisma.TimeslotWhereUniqueInput,
    });

    if (!existingTimeslot) {
      return NextResponse.json(
        { error: "Timeslot not found" },
        { status: 404 }
      );
    }

    const timeslot = await db.timeslot.update({
      where: {
        id,
      } as Prisma.TimeslotWhereUniqueInput,
      data: {
        startTime,
        endTime,
        maxParticipants,
        currentParticipants,
        isAvailable,
      } as Prisma.TimeslotUpdateInput,
    });

    return NextResponse.json(
      {
        status: "Success",
        message: "Timeslot updated successfully",
        data: { timeslot },
      },
      { status: 200 }
    );
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error: "An error occurred while updating the timeslot" },
      { status: 500 }
    );
  }
}
