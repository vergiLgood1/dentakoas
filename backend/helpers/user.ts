import { UserQueryString } from "@/config/types";
import db from "@/lib/db";
import bcrpyt from "bcryptjs";

/**
 * Get user by email from the database
 * @param email
 * @param include
 * @param select
 * @returns
 */
export const getUserByEmail = async (
  email: string,
  include?: object,
  select?: object
) => {
  try {
    // Validasi: Tidak boleh menggunakan `select` dan `include` bersamaan
    if (select && include) {
      throw new Error(
        "Cannot use both `select` and `include` at the same time"
      );
    }

    const user = await db.user.findUnique({
      where: {
        email,
      },
      ...(include ? { include } : {}), // Gunakan include jika ada
      ...(select ? { select } : {}), // Gunakan select jika ada
    });

    return user;
  } catch (error) {
    return null;
  }
};

/**
 * Get user by ID from the database
 * @param id
 * @param include
 * @param select
 * @returns
 */
export const getUserById = async (
  id: string,
  include?: object,
  select?: object
) => {
  try {
    // Validasi: Tidak boleh menggunakan `select` dan `include` bersamaan
    if (select && include) {
      throw new Error(
        "Cannot use both `select` and `include` at the same time"
      );
    }

    const user = await db.user.findUnique({
      where: {
        id,
      },
      ...(include ? { include } : {}), // Gunakan include jika ada
      ...(select ? { select } : {}), // Gunakan select jika ada
    });

    return user;
  } catch (error) {
    return null;
  }
};

/**
 * Parse the search params from the URL and return an object
 * @param searchParams
 * @returns
 */
export function parseSearchParams(
  searchParams: URLSearchParams
): UserQueryString {
  const query: UserQueryString = {};

  searchParams.forEach((value, key) => {
    query[key] = value; // Simpan setiap parameter ke dalam objek query
  });

  return query;
}

/**
 * Generate a hashed password or return the existing hash if the password is not provided
 * @param password
 * @param existingHash
 * @returns
 */
export async function setHashPassword(
  password: string | undefined,
  existingHash: string
) {
  return password ? await bcrpyt.hash(password, 12) : existingHash;
}

/**
 * Generate a username based on the user's first and last name
 * @param givenName
 * @param familyName
 * @type {string | null}
 * @returns
 */
export async function genUsername(
  givenName: string | null,
  familyName: string | null
) {
  const rand = Math.floor(Math.random() * 1000);
  return `${givenName?.toLowerCase()}.${familyName?.toLowerCase()}${rand}`;
}
