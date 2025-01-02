import { auth } from "@/lib/auth-firebase";

export const getEmailVerificationLink = async (email: string) => {
  const actionCodeSettings = {
    url: `${process.env.NEXTAUTH_URL}/api/auth/new-verification`,
    handleCodeInApp: true,
  };

  // Generate link dengan oobCode
  const emailVerificationLink = await auth.generateEmailVerificationLink(
    email,
    actionCodeSettings
  );

  return emailVerificationLink;
};
