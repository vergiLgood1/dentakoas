import GitHub from "next-auth/providers/github";
import type { NextAuthConfig } from "next-auth";
import Google from "next-auth/providers/google";
import Credentials from "next-auth/providers/credentials";
import { SignInSchema } from "./lib/zod";
import db from "./lib/db";

import { compare } from "bcryptjs";
import { Role } from "./config/enum";

export default {
  providers: [
    Google({
      clientId: process.env.AUTH_GOOGLE_ID,
      clientSecret: process.env.AUTH_GOOGLE_SECRET,
    }),
    Credentials({
      name: "Credentials",
      credentials: {
        email: { label: "Email", type: "email" },
        password: { label: "Password", type: "password" },
      },
      async authorize(credentials) {
        const validateFields = SignInSchema.safeParse(credentials);

        if (!validateFields.success) {
          return null;
        }

        const { email, password } = validateFields.data;

        const user = await db.users.findUnique({
          where: {
            email: email,
          },
        });

        if (!user || !user.password) {
          throw new Error("User not found");
        }

        const passwordMatch = compare(password, user.password);

        if (!passwordMatch) return null;

        return {
          id: user.id,
          name: user.username,
          email: user.email,
          role: user.role as Role,
        };
      },
    }),
  ],
  //   callbacks: {
  //     jwt({ token, user, trigger, session }) {
  //       if (user) {
  //         token.id = user.id as string
  //         token.role = user.role as string
  //       }
  //       if (trigger === "update" && session) {
  //         token = { ...token, ...session }
  //       }
  //       return token
  //     },
  //     session({ session, token }) {
  //       session.user.id = token.id as string
  //       session.user.role = token.role as Role
  //       return session
  //     },
  //   },
} satisfies NextAuthConfig;
