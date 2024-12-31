import { VerificationEmailTemplate } from "@/components/email-template";
import { render } from "@react-email/render";
import { Resend } from "resend";

const resend = new Resend(process.env.RESEND_API_KEY);

export const sendVerificationEmail = async (email: string, token: string) => {
  const confirmLink = `${process.env.NEXTAUTH_URL}/api/auth/new-verification?token=${token}`;

  await resend.emails.send({
    from: "Denta Koas <onboarding@resend.dev>",
    to: email,
    subject: "Confirm your email",
    react: VerificationEmailTemplate({ confirmLink }),
  });
};
