import { NextResponse } from "next/server";
import * as z from "zod";

/**
 * Validates the given name with constraints:
 * - Minimum length: 1 character
 * - Maximum length: 32 characters
 * @type {z.ZodString}
 */
export const valGivenName = z
  .string()
  .min(1, { message: "Given name must be more than 1 character" })
  .max(32, { message: "Given name must be less than 32 characters" });

/**
 * Validates the family name with constraints:
 * - Minimum length: 1 character
 * - Maximum length: 32 characters
 * @type {z.ZodString}
 */
export const valFamilyName = z
  .string()
  .min(1, { message: "Family name must be more than 1 character" })
  .max(32, { message: "Family name must be less than 32 characters" });

/**
 * Validates an email address.
 * Ensures the input is a valid email format.
 * @type {z.ZodString}
 */
export const valEmail = z.string().email({ message: "Invalid email format" });

/**
 * Validates a password with constraints:
 * - Minimum length: 8 characters
 * @type {z.ZodString}
 */
export const valPassword = z
  .string({ message: "Invalid password" })
  .min(8, { message: "Password must be at least 8 characters long" });

/**
 * Validates a confirmation password with constraints:
 * - Minimum length: 8 characters
 * - Maximum length: 32 characters
 * @type {z.ZodString}
 */
export const valConfirmPassword = z
  .string({ message: "Invalid confirm password" })
  .min(8, { message: "Password must be more than 8 characters" })
  .max(32, { message: "Password must be less than 32 characters" });

/**
 * Validates the user role.
 * Accepted values: "Koas", "Pasien", "Admin".
 * @type {z.ZodEnum}
 */
export const valRole = z.enum(["Koas", "Pasien", "Admin"]);

/**
 * Validates a phone number (optional field).
 * Ensures the number has at least 10 characters if provided.
 * @type {z.ZodString | z.ZodOptional}
 */
export const valPhone = z
  .string()
  .min(10, { message: "Invalid phone number" })
  .optional();

/**
 * Generic reusable function to validate data against a given Zod schema.
 * @template T
 * @param {z.ZodSchema<T>} schema - The Zod schema to validate against.
 * @param {T} data - The data object to validate.
 * @returns {{ success: boolean; errors: any }} Validation result.
 */
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

/**
 * Validates if the given properties exist in the user object.
 * @param {object} user - The object to validate.
 * @param {string[]} properties - Array of property names to check.
 * @returns {boolean | NextResponse} Returns true if all properties exist, otherwise returns a NextResponse error.
 */
export function valProps(user: any, properties: string[]) {
  // Loop through each property in the list
  for (const prop of properties) {
    if (!user || !user[prop]) {
      return NextResponse.json({ error: `${prop} not found` }, { status: 404 });
    }
  }

  return true; // return true if all validations pass
}
