// app/components/SignIn.tsx
"use client"

import { signIn } from "next-auth/react"

export default function SignIn() {
  return (
    <div>
      <button onClick={() => signIn("google")}>Signin with Google</button>
    </div>
  )
}
