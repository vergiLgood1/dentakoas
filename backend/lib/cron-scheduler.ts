import {
  updateCompletedAppointments,
  updateExpiredAppointments,
  updateOngoingAppointments,
} from "@/helpers/appointments";
import { updateExpiredPosts } from "@/helpers/post";
import cron from "node-cron";

export function startCronJobs() {
  // Daily jobs (00:00)
  cron.schedule("0 0 * * *", async () => {
    await updateExpiredPosts();
    await updateExpiredAppointments();
  });

  // Per-minute jobs
  cron.schedule("* * * * *", async () => {
    await updateOngoingAppointments();
    await updateCompletedAppointments();
  });
}

export async function oneTimeCronJobs() {
  console.log("Running one-time cron jobs...");

  await updateExpiredPosts();
  await updateExpiredAppointments();
  await updateOngoingAppointments();
  await updateCompletedAppointments();

  console.log("One-time cron jobs completed.");
}
