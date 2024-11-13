import { UserQueryParams } from "@/config/types";
import db from "@/lib/db";
import bcrpyt from "bcryptjs";

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

// Fungsi untuk memproses searchParams dan mengonversinya menjadi query object
export function parseSearchParams(
  searchParams: URLSearchParams
): UserQueryParams {
  const query: UserQueryParams = {};

  searchParams.forEach((value, key) => {
    query[key] = value; // Simpan setiap parameter ke dalam objek query
  });

  return query;
}

export async function setHashPassword(
  password: string | undefined,
  existingHash: string
) {
  return password ? await bcrpyt.hash(password, 12) : existingHash;
}

export async function setUsername(firstname: string | null, lastname: string | null) {
  const rand = Math.floor(Math.random() * 1000);
  return `${firstname?.toLowerCase()}.${lastname?.toLowerCase()}${rand}`;
}
