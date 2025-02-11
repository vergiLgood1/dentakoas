import { updateExpiredAppointments } from "@/helpers/appointments";
import { updateExpiredPosts } from "@/helpers/post";
import { NextResponse } from "next/server";

export async function GET(req: Request) {
  try {
    await updateExpiredPosts();
    await updateExpiredAppointments();
    return NextResponse.json({ message: "Cron jobs check expired execute" });
  } catch (error) {
    console.error("Error fetching Timeslots", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
