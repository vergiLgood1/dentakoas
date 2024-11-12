import NextAuth, { DefaultSession } from "next-auth";
import { Role } from "@/config/enum";

export type ExtendedUser = DefaultSession["user"] & {
  role: Role;
};

declare module "next-auth" {
  interface Session {
    user: ExtendedUser;
  }
}
