import db from "@/lib/db";
import { getUserByEmail } from "./user";

export const getVerificationOtpByOtp = async (otp: string) => {
  try {
    const verificationOtp = await db.otp.findUnique({
      where: { otp },
    });

    return verificationOtp;
  } catch (error) {
    console.error(error);
    return null;
  }
};

export const getVerificationOtpByEmail = async (email: string) => {
  try {
    const verificationOtp = await db.otp.findFirst({
      where: { email },
    });

    return verificationOtp;
  } catch (error) {
    console.error(error);
    return null;
  }
};
