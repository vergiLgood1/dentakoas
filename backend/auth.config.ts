import type { NextAuthConfig } from "next-auth";
import GitHub from "next-auth/providers/github";
import Google from "next-auth/providers/google";
import Credentials from "next-auth/providers/credentials";
import db from "@/lib/db";
 
import { compare } from "bcryptjs";

import { SignInSchema } from "@/lib/schemas";
import { getUserByEmail } from "@/helpers/user";
import { csrfToken } from "./lib/tokens";
import { cookies } from "next/headers";

export default {
  session: { strategy: "jwt" },
  providers: [
    Google({
      clientId: process.env.GOOGLE_CLIENT_ID,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET,
    }),
    GitHub({
      clientId: process.env.GITHUB_CLIENT_ID,
      clientSecret: process.env.GITHUB_CLIENT_SECRET,
    }),
    Credentials({
      name: "Credentials",
      credentials: {
        email: { label: "Email", type: "email" },
        password: { label: "Password", type: "password" },
      },
      async authorize(credentials) {
        const validatedFields = SignInSchema.safeParse(credentials);

        if (validatedFields.success) {
          const { email, password } = validatedFields.data;

          const existingUser = await getUserByEmail(email);

          if (!existingUser || !existingUser.email || !existingUser.password) {
            return null;
          }

          const passwordMatch = await compare(password, existingUser.password);

          if (passwordMatch) return existingUser;
        }

        return null;
      },
    }),
  ],
} satisfies NextAuthConfig;
 
 