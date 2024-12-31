import {
  getVerificationTokenByEmail,
  getVerificationTokenByToken,
} from "@/helpers/verification-token";
import { v4 as uuidv4 } from "uuid";
import db from "./db";
import { getUserByEmail } from "@/helpers/user";

export const generateVerificationToken = async (email: string) => {
  const token = uuidv4();
  const expires = new Date(new Date().getTime() + 3600 * 1000); // 1 hour

  const existingToken = await getVerificationTokenByEmail(email);

  if (existingToken) {
    await db.verificationRequest.delete({
      where: {
        id: existingToken.id,
      },
    });
  }

  const verificationToken = await db.verificationRequest.create({
    data: {
      email,
      token,
      expires,
    },
  });

  return verificationToken;
};

export const newVerification = async (token: string) => {
  const existingToken = await getVerificationTokenByToken(token);

  if (!existingToken) {
    return { error: "Token not found" };
  }

  const hasExpired = new Date(existingToken.expires) < new Date();

  if (hasExpired) {
    return { error: "Token has expired" };
  }

  const existingUser = await getUserByEmail(existingToken.email);

  if (!existingUser) {
    return { error: "Email not found" };
  }

  await db.user.update({
    where: { id: existingUser.id },
    data: { emailVerified: new Date(), email: existingToken.email },
  });

  await db.verificationRequest.delete({
    where: { id: existingToken.id },
  });

  return { success: "Email verified" };
};
