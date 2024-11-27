import { Prisma } from "@prisma/client";

export function getDateRange(
  filter: string
): { gte: string; lte: string } | null {
  const now = new Date();
  let startDate: Date;
  let endDate: Date;

  switch (filter) {
    case "today":
      startDate = new Date(now.setHours(0, 0, 0, 0));
      endDate = new Date(now.setHours(23, 59, 59, 999));
      break;

    case "this_week":
      startDate = new Date(new Date().setDate(now.getDate() - now.getDay()));
      startDate.setHours(0, 0, 0, 0);
      endDate = new Date(new Date().setDate(now.getDate() - now.getDay() + 6));
      endDate.setHours(23, 59, 59, 999);
      break;

    case "this_month":
      startDate = new Date(now.getFullYear(), now.getMonth(), 1);
      endDate = new Date(
        now.getFullYear(),
        now.getMonth() + 1,
        0,
        23,
        59,
        59,
        999
      );
      break;

    case "this_year":
      startDate = new Date(now.getFullYear(), 0, 1);
      endDate = new Date(now.getFullYear(), 11, 31, 23, 59, 59, 999);
      break;

    default:
      return null;
  }

  return {
    gte: startDate.toISOString(),
    lte: endDate.toISOString(),
  };
}

// Fungsi untuk menghasilkan schedule dates
export function genSchedules(startDate: Date, endDate: Date): Date[] {
  const scheduleDates: Date[] = [];
  let currentDate = new Date(startDate);

  while (currentDate <= endDate) {
    scheduleDates.push(new Date(currentDate)); // Salin tanggal
    currentDate.setDate(currentDate.getDate() + 1); // Tambahkan satu hari
  }

  return scheduleDates;
}

// Fungsi untuk menghasilkan timeslots berdasarkan koas start dan end time
export function genTimeSlots(
  scheduleDate: Date,
  startTime: string,
  endTime: string,
  scheduleId: string
): Prisma.TimeslotCreateInput[] {
  const timeslots: Prisma.TimeslotCreateInput[] = [];

  // Mengubah startTime dan endTime menjadi objek Date
  const start = new Date(scheduleDate);
  const end = new Date(scheduleDate);

  const [startHours, startMinutes] = startTime.split(":").map(Number);
  const [endHours, endMinutes] = endTime.split(":").map(Number);

  start.setHours(startHours, startMinutes, 0, 0);
  end.setHours(endHours, endMinutes, 0, 0);

  // Menambahkan timeslot ke array
  timeslots.push({
    startTime: start.toISOString(),
    endTime: end.toISOString(),
    schedule: {
      connect: { id: scheduleId },
    },
  });

  return timeslots;
}
