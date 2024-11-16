import * as z from "zod";
import { NextResponse } from "next/server";

export const SignUpSchema = z
  .object({
    given_name: z.string().min(1, "given_name must be more than 1 character"),
    family_name: z.string().min(1, "family_name must be more than 1 character"),
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
