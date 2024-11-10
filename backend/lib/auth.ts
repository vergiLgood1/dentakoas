
import { PrismaAdapter } from "@auth/prisma-adapter"
import db from "@/lib/db"
import type { Adapter } from "next-auth/adapters"
import Credentials from "next-auth/providers/credentials"
import Google from "next-auth/providers/google"
import { Role } from "@/config/enum"
import { SignInSchema } from "./zod"
import { compare } from "bcryptjs"
import NextAuth from "next-auth"

export const { handlers, auth, signIn, signOut } = NextAuth({
  adapter: PrismaAdapter(db) as Adapter,
  session: {
    strategy: "jwt",
  },
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
        const validateFields = SignInSchema.safeParse(credentials)

        if (!validateFields.success) {
          return null
        }

        const { email, password } = validateFields.data

        const user = await db.users.findUnique({
          where: {
            email: email,
          },
        })

        if (!user || !user.password) {
          throw new Error("User not found")
        }

        const passwordMatch = compare(password, user.password)

        if (!passwordMatch) return null

        return {
          id: user.id,
          name: user.username,
          email: user.email,
          role: user.role as Role,
        }
      },
    }),
  ],
  callbacks: {
    async jwt({ token, trigger, user, session, account }) {
      if (trigger === "update") token.name = session.user.name

      if (user) token.user = user

      // Jika ada account (untuk OAuth login), tambahkan accessToken ke token
      if (account) {
        token.accessToken = account.access_token
      }

      return token
    },
    async session({ session, user }) {
      return {
        ...session,
        user: {
          ...session.user,
          id: user.id,
          email: user.email,
          role: session.user?.role,
        },
      }
    },
  },
  secret: process.env.NEXTAUTH_SECRET,
})
