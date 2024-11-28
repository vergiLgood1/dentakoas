import db from "@/lib/db";

// Definisikan model dengan tipe Prisma yang tepat
export const prismaModels = {
  users: db.user,
  posts: db.post,
  koasProfiles: db.koasProfile,
  pasienProfiles: db.pasienProfile,
  treatmentTypes: db.treatmentType,
  likes: db.like,
  schedules: db.schedule,
  timeslots: db.timeslot,
  appointments: db.appointment,
  reviews: db.review,
} as const;
