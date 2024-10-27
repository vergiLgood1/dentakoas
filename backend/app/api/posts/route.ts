import { NextResponse } from "next/server"
import db from "@/lib/db"
import { StatusKoas } from "@/config/types"
import { Prisma } from "@prisma/client"

export async function GET(req: Request) {
  try {
    const posts = await db.posts.findMany()
    return NextResponse.json(posts, { status: 200 })
  } catch (error) {
    console.error("Error fetching posts", error)
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    )
  }
}

