import {
  getVerificationOtpByEmail,
  getVerificationOtpByOtp,
} from "@/helpers/verification-token";
import db from "./db";
import { getUserByEmail } from "@/helpers/user";

export const generateOtp = async (email: string) => {
  const otp = Math.floor(10000 + Math.random() * 90000); // 5 digit OTP
  const expires = new Date(new Date().getTime() + 10 * 60 * 1000); // 10 minutes

  const existingOtp = await getVerificationOtpByEmail(email);

  if (existingOtp) {
    await db.otp.delete({
      where: {
        id: existingOtp.id,
      },
    });
  }

  const verificationOtp = await db.otp.create({
    data: {
      email,
      otp: otp.toString(),
      expires,
    },
  });

  console.log("otp berhasil dibuuat : ", verificationOtp);

  return verificationOtp;
};

export const compareOtp = async (otp: string) => {
  const existingOtp = await getVerificationOtpByOtp(otp);

  if (!existingOtp) {
    return { error: "Otp not found" };
  }

  const hasExpired = new Date(existingOtp.expires) < new Date();

  if (hasExpired) {
    return { error: "Otp has expired" };
  }

  const existingUser = await getUserByEmail(existingOtp.email);

  if (!existingUser) {
    return { error: "Email not found" };
  }

  // await db.user.update({
  //   where: { id: existingUser.id },
  //   data: { emailVerified: new Date(), email: existingOtp.email },
  // });

  await db.otp.delete({
    where: { id: existingOtp.id },
  });

  return { success: "OTP verified" };
};

// export const compareOtp = async (email: string, otp: string) => {
//   const existingOtp = await getVerificationOtpByEmail(email);

//   if (!existingOtp) {
//     return { error: "Otp not found" };
//   }

//   if (existingOtp.otp !== otp) {
//     return { error: "Otp does not match" };
//   }

//   const hasExpired = new Date(existingOtp.expires) < new Date();

//   if (hasExpired) {
//     return { error: "Otp has expired" };
//   }

//   return { success: "Otp is valid" };
// };
