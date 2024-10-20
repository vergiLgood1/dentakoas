// userHelpers.ts
import db from "@/lib/db";
import bcrypt from "bcryptjs";

// Helper untuk mendapatkan user berdasarkan ID
export async function getUserId(userId: string) {
  const user = await db.users.findUnique({ where: { id: String(userId) } });
  if (!user) {
    throw new Error("User not found");
  }
  return user;
}

// Helper untuk melakukan hashing password
export async function getPassword(password: string | undefined, existingHash: string) {
  return password ? await bcrypt.hash(password, 12) : existingHash;
}
