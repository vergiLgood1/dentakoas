import * as z from "zod";

import {
  valConfirmPassword,
  valEmail,
  valFamilyName,
  valGivenName,
  valPassword,
  valPhone,
  valRole,
} from "@/lib/validations";

export const SignUpSchema = z
  .object({
    givenName: valGivenName,
    familyName: valFamilyName,
    email: valEmail,
    password: valPassword,
    confirmPassword: valConfirmPassword,
    // role: valRole,
    // phone: valPhone,
  })
  .refine((data) => data.password === data.confirmPassword, {
    message: "Password does not match",
    path: ["confirmPassword"],
  });

export const SignInSchema = z.object({
  email: valEmail,
  password: valPassword,
});
