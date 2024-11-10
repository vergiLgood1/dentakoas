import NextAuth, { DefaultSession, DefaultUser } from "next-auth"
import { JWT } from "next-auth/jwt"
import { Role } from "@/config/enum"
import { DefaultSession, DefaultUser } from "next-auth"
import { DefaultJWT } from "next-auth/jwt"

declare module "next-auth" {
  interface Session extends DefaultSession {
    accessToken?: string
    user: {
      id: string
      email: string
      role: Role
    } & DefaultSession["user"]
  }

  interface User extends DefaultUser {
    id: string
    email: string
    role: Role
    accessToken?: string
  }

  interface JWT extends DefaultJWT {
    id: string
    email: string
    role: Role
    accessToken?: string
  }
}
