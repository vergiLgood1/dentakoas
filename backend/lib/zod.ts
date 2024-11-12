import * as z from "zod";
import { NextResponse } from "next/server";

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

export const SignUpSchema = z
  .object({
    firstname: z.string().min(1, "Firstname must be more than 1 character"),
    lastname: z.string().min(1, "Lastname must be more than 1 character"),
    email: z.string().email({
      message: "Invalid email format",
    }),
    password: z
      .string()
      .min(8, "Password must be more than 8 characters")
      .max(32, "Password must be less than 3 2characters"),
    confirmPassword: z
      .string()
      .min(8, "Password must be more than 8 characters")
      .max(32, "Password must be less than 32 characters"),
    role: z.enum(["Koas", "Pasien", "Admin"]),
    phone_number: z.string().min(10).optional(),
  })
  .refine((data) => data.password === data.confirmPassword, {
    message: "Password does not match",
    path: ["confirmPassword"],
  });

export const SignInSchema = z.object({
  email: z.string().email({
    message: "Email is required",
  }),
  password: z
    .string()
    .min(8, {
      message: "Password must be more than 8 characters",
    })
    .max(32, {
      message: "Password must be less than 32 characters",
    }),
});
