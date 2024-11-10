// app/page.tsx (Homepage)
"use client"

import Link from "next/link"
import { useSession } from "next-auth/react"

export default function HomePage() {
  const { data: session } = useSession()

  return (
    <div>
      <h1>Welcome to Next.js 14 App</h1>
      {session ? (
        <Link href="/dashboard">Go to Dashboard</Link>
      ) : (
        <Link href="/auth/sign-in">Sign In</Link>
      )}
    </div>
  )
}
