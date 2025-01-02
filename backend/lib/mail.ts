import { OTPEmailTemplate } from "@/components/email-template";
import { render } from "@react-email/render";
import { Resend } from "resend";
import { generateOtp } from "./otp";

const resend = new Resend(process.env.RESEND_API_KEY);

export const sendOtpResetPassword = async (email: string, otp: string) => {
  const otpLink = `${process.env.NEXTAUTH_URL}/api/auth/reset-password?otp=${otp}`;

  console.log("OTP Link: ", otpLink);

  await resend.emails.send({
    from: "Denta Koas <onboarding@resend.dev>",
    to: email,
    subject: "Reset Password",
    react: OTPEmailTemplate({ OTP: otp }),
  });
};
