import db from "@/lib/db";
import { getUserByEmail } from "./user";

export const getVerificationTokenByToken = async (token: string) => {
  try {
    const verificationToken = await db.verificationRequest.findUnique({
      where: { token },
    });

    return verificationToken;
  } catch (error) {
    console.error(error);
    return null;
  }
};

export const getVerificationTokenByEmail = async (email: string) => {
  try {
    const verificationToken = await db.verificationRequest.findFirst({
      where: { email },
    });

    return verificationToken;
  } catch (error) {
    console.error(error);
    return null;
  }
};
