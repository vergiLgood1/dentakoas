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
import { cookies } from "next/headers";

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
  // const routeRoles = userRole ? ROUTE_ROLES[userRole] : undefined;

  // if (routeRoles?.length && !routeRoles.includes(nextUrl.pathname)) {
  //   return NextResponse.redirect(new URL(DEFAULT_PROTECTED_REDIRECT, nextUrl));
  // }

  if (isApiAuthRoute || isApiPublicRoute) {
    const response = NextResponse.next();

    // Example of setting CSRF token in the cookie
    // Set CSRF token (you can replace this logic with actual CSRF token generation)

    const csrfToken = cookies().get("authjs.csrf-token")?.value ?? "";
    // Set the CSRF token as a cookie in the response
    response.cookies.set("authjs.csrf-token", csrfToken, {
      path: "/", // Set path to '/' for global access to the cookie
      httpOnly: true, // Set to true for security to prevent client-side access
      secure: process.env.NODE_ENV === "production", // Use secure cookies in production
      sameSite: "strict", // Adjust according to your needs
    });

    // Tambahkan Header CORS
    response.headers.set("Access-Control-Allow-Origin", "*"); // Gunakan domain spesifik untuk keamanan
    response.headers.set(
      "Access-Control-Allow-Methods",
      "GET, POST, PATCH, OPTIONS"
    );
    response.headers.set(
      "Access-Control-Allow-Headers",
      "Content-Type, Authorization, X-Requested-With"
    );
    response.headers.set("Access-Control-Allow-Credentials", "true");

    return response;
  }

  // if (isAuthRoute) {
  //   if (isLoggedIn) {
  //     return NextResponse.redirect(new URL(DEFAULT_LOGIN_REDIRECT, nextUrl));
  //   }
  //   return;
  // }

  // if (!isLoggedIn && !isPublicRoute) {
  //   return NextResponse.redirect(new URL(DEFAULT_PROTECTED_REDIRECT, nextUrl));
  // }

  return;
});

export const config = {
  matcher: ["/((?!.*\\..*|_next).*)", "/", "/(api|trpc)(.*)"],
};
