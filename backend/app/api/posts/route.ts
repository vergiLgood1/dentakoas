import { NextResponse } from "next/server"
import db from "@/lib/db"

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

export async function POST(req: Request) {
    const body = await req.json()

}