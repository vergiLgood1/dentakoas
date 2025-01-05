import db from "@/lib/db";

/**
 * Get user profile by userId from the database
 * @param userId
 * @param include
 * @param select
 * @returns
 */

export const getUserProfileById = async (
  userId: string,
  include?: object,
  select?: object
) => {
  try {
    // ValuserIdasi: TuserIdak boleh menggunakan `select` dan `include` bersamaan
    if (select && include) {
      throw new Error(
        "Cannot use both `select` and `include` at the same time"
      );
    }

    const profile = await db.user.findUnique({
      where: {
        id: userId,
      },
      ...(include ? { include } : {}), // Gunakan include jika ada
      ...(select ? { select } : {}), // Gunakan select jika ada
    });

    return profile;
  } catch (error) {
    return null;
  }
};

