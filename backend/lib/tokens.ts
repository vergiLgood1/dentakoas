import { cookies, type UnsafeUnwrappedCookies } from "next/headers";

export const csrfToken = (cookies() as unknown as UnsafeUnwrappedCookies).get("authjs.csrf-token")?.value ?? "";

