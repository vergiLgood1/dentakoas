import { updateCompletedAppointments, updateOngoingAppointments } from "@/helpers/appointments";
import { startCronJobs } from "@/lib/cron-scheduler";
import { NextApiRequest, NextApiResponse } from "next";
import { NextResponse } from "next/server";

let cronStarted = false;
export async function GET(req: Request) {
  try {
    await updateOngoingAppointments();
    await updateCompletedAppointments();
    return NextResponse.json({ message: "Cron jobs update appointments execute" });
  } catch (error) {
    console.error("Error fetching Timeslots", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
