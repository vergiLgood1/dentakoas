import NextAuth from "next-auth";
import authConfig from "@/auth.config";
import { PrismaAdapter } from "@auth/prisma-adapter";
import { PrismaClient } from "@prisma/client";

import { getUserById, genUsername } from "./helpers/user";
import { Role } from "@/config/enum";
import db from "@/lib/db";

const prisma = new PrismaClient({
  log: ["query", "info", "warn", "error"],
});

export const { auth, handlers, signIn, signOut } = NextAuth({
  adapter: PrismaAdapter(prisma),
  callbacks: {
    async session({ token, session }) {
      // console.log("session", session, "token", token);
      if (token.sub && session.user) {
        session.user.id = token.sub;
        session.user.name = token.name;
      }

      if (token.role && session.user) {
        session.user.role = token.role as Role;
      }

      return session;
    },
    async jwt({ token }) {
      if (!token.sub) return token;
      const existingUser = await getUserById(token.sub);

      if (!existingUser) return token;

      const username = await genUsername(
        existingUser.firstname,
        existingUser.lastname
      );

      if (existingUser) {
        token.role = existingUser.role;
      }

      if (token.isNewUser && !existingUser.username) {
        token.name = username;
      } else {
        token.name = existingUser.username;
      }

      console.log("token", token);

      return token;
    },
  },
  ...authConfig,
  secret: process.env.AUTH_SECRET,
  debug: true,
});
