import { startCronJobs } from "@/lib/cron-scheduler";
import { NextApiRequest, NextApiResponse } from "next";
import { NextResponse } from "next/server";

let cronStarted = false;
export async function GET(req: Request) {
  try {
    startCronJobs();
    return NextResponse.json({ message: "Cron jobs executed" });
  } catch (error) {
    console.error("Error fetching Timeslots", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
