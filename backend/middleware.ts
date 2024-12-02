import NextAuth from "next-auth";
import authConfig from "./auth.config";

import {
  DEFAULT_LOGIN_REDIRECT,
  DEFAULT_PROTECTED_REDIRECT,
  ROUTE_ROLES,
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
  const userRole = req.auth?.user.role;

  const isApiAuthRoute = nextUrl.pathname.startsWith(apiAuthPrefix);
  const isApiPublicRoute = apiPublicRoutes.includes(nextUrl.pathname);
  const isPublicRoute = publicRoutes.includes(nextUrl.pathname);
  const isAuthRoute = authRoutes.includes(nextUrl.pathname);

  // Role-Based-Access Control
  const routeRoles = userRole ? ROUTE_ROLES[userRole] : undefined;

  if (routeRoles?.length && !routeRoles.includes(nextUrl.pathname)) {
    return NextResponse.redirect(new URL(DEFAULT_PROTECTED_REDIRECT, nextUrl));
  }

  if (isApiAuthRoute || isApiPublicRoute) {
    return;
  }

  if (isAuthRoute) {
    if (isLoggedIn) {
      return NextResponse.redirect(new URL(DEFAULT_LOGIN_REDIRECT, nextUrl));
    }
    return;
  }

  if (!isLoggedIn && !isPublicRoute) {
    return NextResponse.redirect(new URL(DEFAULT_PROTECTED_REDIRECT, nextUrl));
  }

  return;
});

export const config = {
  matcher: ["/((?!.*\\..*|_next).*)", "/", "/(api|trpc)(.*)"],
};
