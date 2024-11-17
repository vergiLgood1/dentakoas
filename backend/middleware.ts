import NextAuth from "next-auth";
import authConfig from "./auth.config";

import {
  DEFAULT_LOGIN_REDIRECT,
  DEFAULT_PROTECTED_REDIRECT,
  apiAuthPrefix,
  apiPublicRoutes,
  authRoutes,
  publicRoutes,
} from "@/routes";
import { NextResponse } from "next/server";

const { auth } = NextAuth(authConfig);

export default auth((req) => {
  const { nextUrl } = req;
  const isLoggedIn = !!req.auth;

  const isApiAuthRoute = nextUrl.pathname.startsWith(apiAuthPrefix);
  const isApiPublicRoute = apiPublicRoutes.includes(nextUrl.pathname);
  const isPublicRoute = publicRoutes.includes(nextUrl.pathname);
  const isAuthRoute = authRoutes.includes(nextUrl.pathname);

  // if (isApiAuthRoute || isApiPublicRoute) {
  //   return;
  // }

  // if (isAuthRoute) {
  //   if (isLoggedIn) {
  //     return NextResponse.redirect(new URL(DEFAULT_LOGIN_REDIRECT, nextUrl));
  //   }
  //   return;
  // }

  // if (!isLoggedIn && !isPublicRoute && !isApiPublicRoute) {
  //   return NextResponse.redirect(new URL(DEFAULT_PROTECTED_REDIRECT, nextUrl));
  // }

  return;
});

export const config = {
  matcher: ["/((?!.*\\..*|_next).*)", "/", "/(api|trpc)(.*)"],
};
