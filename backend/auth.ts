import NextAuth from "next-auth";
import { PrismaAdapter } from "@auth/prisma-adapter";
import { PrismaClient } from "@prisma/client";
import authConfig from "./auth.config";
import { getUserById } from "./helpers/user";
import { Role } from "@/config/enum";

const prisma = new PrismaClient();

export const { auth, handlers, signIn, signOut } = NextAuth({
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

      if (existingUser) {
        token.role = existingUser.role;
        token.name = existingUser.username;
      }

      console.log("token", token);

      return token;
    },
  },
  adapter: PrismaAdapter(prisma),
  session: { strategy: "jwt" },
  ...authConfig,
});
