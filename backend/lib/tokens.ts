import { cookies } from "next/headers";

export const csrfToken = cookies().get("authjs.csrf-token")?.value ?? "";

