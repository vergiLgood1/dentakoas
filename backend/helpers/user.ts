import { UserQueryParams } from "@/config/types";
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
    const user = await db.users.findUnique({
      where: {
        email,
      },
      include,
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
    const user = await db.users.findUnique({
      where: {
        id,
      },
      include,
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
): UserQueryParams {
  const query: UserQueryParams = {};

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
 * @param firstname
 * @param lastname
 * @returns
 */
export async function genUsername(
  firstname: string | null,
  lastname: string | null
) {
  const rand = Math.floor(Math.random() * 1000);
  return `${firstname?.toLowerCase()}.${lastname?.toLowerCase()}${rand}`;
}
