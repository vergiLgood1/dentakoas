import { NextResponse } from "next/server";
import * as z from "zod";

// Skema reusable untuk validasi email
const valEmail = z.string().email({ message: "Invalid email format" });

// Skema reusable untuk validasi password
const valPassword = z
  .string({ message: "Invalid password" })
  .min(8, { message: "Password must be at least 8 characters long" })
  .regex(/[a-z]/, {
    message: "Password must contain at least one lowercase letter",
  })
  .regex(/[A-Z]/, {
    message: "Password must contain at least one uppercase letter",
  })
  .regex(/[0-9]/, { message: "Password must contain at least one number" });

// Skema untuk validasi nomor telepon (opsional, bisa disesuaikan)
const valPhone = z.string().min(10, { message: "Invalid phone number" });

// Skema validasi untuk User
export const userValidation = z.object({
  firstname: z
    .string()
    .min(1, { message: "First name is required" })
    .max(255, { message: "Firs name is too long" }),
  lastname: z
    .string()
    .min(1, { message: "Last name is required" })
    .max(255, { message: "Last name is too long" }),
  email: valEmail,
  password: valPassword,
  phone_number: valPhone.optional(),
  role: z.enum(["KOAS", "PASIEN", "ADMIN"], { message: "Invalid role" }),
});

// Fungsi reusable untuk validasi berdasarkan schema yang diberikan
export const validateData = <T>(schema: z.ZodSchema<T>, data: T) => {
  try {
    schema.parse(data);
    return { success: true, errors: null };
  } catch (e) {
    if (e instanceof z.ZodError) {
      return { success: false, errors: e.errors };
    }
    // Optional: handle other types of errors if necessary
    return { success: false, errors: [{ message: "Unknown error occurred" }] };
  }
};

// Reusable dynamic function to validate if a property exists in the user object
export function valProps(user: any, properties: string[]) {
  // Loop through each property in the list
  for (const prop of properties) {
    if (!user || !user[prop]) {
      return NextResponse.json({ error: `${prop} not found` }, { status: 404 });
    }
  }

  return true; // return true if all validations pass
}
