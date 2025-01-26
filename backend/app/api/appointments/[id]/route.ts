import db from "@/lib/db";
import { getFieldById } from "@/utils/common";
import { NextResponse } from "next/server";

export async function PATCH(req: Request, props: { params: Promise<{ id: string }> }) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const id = searchParams.get("id") || params.id;

  const body = await req.json();
  const { status, scheduleId, pasienId, koasId, timeslotId } = body;

  try {
    // Cek apakah schedule, pasien, dan koas valid
    const schedule = await db.schedule.findUnique({
      where: { id: scheduleId },
      include: {
        post: true, // Mengambil data post terkait untuk validasi requiredParticipant
        timeslot: true, // Mengambil semua timeslot terkait schedule
      },
    });

    const pasien = await db.pasienProfile.findUnique({
      where: { id: pasienId },
    });

    const koas = await db.koasProfile.findUnique({
      where: { id: koasId },
    });

    if (!schedule || !pasien || !koas) {
      return NextResponse.json(
        { error: "Invalid schedule, pasien or koas" },
        { status: 404 }
      );
    }

    // Cek apakah timeslotId yang dipilih ada dalam schedule
    const selectedTimeslot = schedule.timeslot.find(
      (slot) => slot.id === timeslotId
    );

    if (!selectedTimeslot) {
      return NextResponse.json(
        { error: "Timeslot not found for the given schedule" },
        { status: 404 }
      );
    }

    const existingAppointment = await db.appointment.findUnique({
      where: {
        id,
      },
    });

    if (!existingAppointment) {
      return NextResponse.json(
        { error: "Appointment not found" },
        { status: 404 }
      );
    }

    if (
      (!selectedTimeslot.isAvailable && status === "Pending") ||
      status === "Canceled"
    ) {
      const updateTimeslot = await db.timeslot.update({
        where: { id: timeslotId },
        data: {
          currentParticipants: selectedTimeslot.currentParticipants - 1,
        },
      });

      if (
        updateTimeslot.maxParticipants !== null &&
        updateTimeslot.currentParticipants < updateTimeslot.maxParticipants
      ) {
        await db.timeslot.update({
          where: { id: timeslotId },
          data: {
            isAvailable: true,
          },
        });
      }
    }

    if (!selectedTimeslot.isAvailable && status === "Confirmed") {
      return NextResponse.json(
        { error: "Timeslot is fully booked or unavailable." },
        { status: 400 }
      );
    }

    const appointment = await db.appointment.update({
      where: { id },
      data: {
        status,
      },
    });

    if (appointment.status === "Confirmed") {
      // Update jumlah peserta dalam timeslot
      const updatedTimeslot = await db.timeslot.update({
        where: { id: timeslotId },
        data: {
          currentParticipants: selectedTimeslot.currentParticipants + 1,
        },
      });

      if (updatedTimeslot.maxParticipants === null) return;

      if (
        updatedTimeslot.currentParticipants >= updatedTimeslot.maxParticipants
      ) {
        await db.timeslot.update({
          where: { id: timeslotId },
          data: {
            isAvailable: false,
          },
        });
      }
    }

    // if (appointment.status != "Confirmed") {
    //   const updatedTimeslot = await db.timeslot.update({
    //     where: { id: timeslotId },
    //     data: {
    //       currentParticipants: selectedTimeslot.currentParticipants - 1,
    //     },
    //   });

    //   if (updatedTimeslot.maxParticipants === null) return;

    //   if (
    //     updatedTimeslot.currentParticipants < updatedTimeslot.maxParticipants
    //   ) {
    //     await db.timeslot.update({
    //       where: { id: timeslotId },
    //       data: {
    //         isAvailable: true,
    //       },
    //     });
    //   }
    // }

    // Validasi apakah jumlah total peserta sudah mencapai requiredParticipant di post
    const totalParticipants = await db.appointment.count({
      where: {
        scheduleId: schedule.id,
        status: "Confirmed", // Cek hanya yang sudah dikonfirmasi
      },
    });

    if (totalParticipants >= schedule.post.requiredParticipant) {
      await db.post.update({
        where: { id: schedule.post.id },
        data: { status: "Closed" },
      });

      await db.appointment.updateMany({
        where: {
          scheduleId: schedule.id,
          status: "Pending",
        },
        data: {
          status: "Rejected",
        },
      });

      return NextResponse.json(
        { success: "Required participants for the post have been met." },
        { status: 200 }
      );
    }

    if (totalParticipants < schedule.post.requiredParticipant) {
      await db.post.update({
        where: { id: schedule.post.id },
        data: { status: "Open" },
      });
    }

    return NextResponse.json(
      {
        status: "Success",
        message: "Appointment updated successfully",
        data: { appointment },
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error updating appointment", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}

export async function PUT(req: Request, props: { params: Promise<{ id: string }> }) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const id = searchParams.get("id") || params.id;

  const body = await req.json();
  const { scheduleId, pasienId, koasId, timeslotId, status, date } = body;

  try {
  } catch (error) {
    console.error("Error updating appointment", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}

export async function DELETE(req: Request, props: { params: Promise<{ id: string }> }) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const id = searchParams.get("id") || params.id;

  try {
    if (!id) {
      return NextResponse.json(
        { error: "Appoid is required" },
        { status: 400 }
      );
    }

    await db.appointment.delete({
      where: { id: id },
    });

    return NextResponse.json(
      { message: "Appointment deleted successfully" },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error deleting appointment", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
