import db from "@/lib/db"
import { NextResponse } from "next/server"

export async function GET(
  req: Request,
  { params }: { params: { id: string } }
) {
  const { searchParams } = new URL(req.url)
  const postId = searchParams.get("id") || params.id

  try {
    const likes = await db.likes.findMany({
      where: { postId: postId },
      include: {
        user: true,
      },
      orderBy: {
        userId: "asc",
      },
    })

    if (!likes) {
      return NextResponse.json({ error: "Likes not found" }, { status: 404 })
    }

    const user = likes.map((like) => like.user)
    return NextResponse.json(user, { status: 200 })
  } catch (error) {
    console.error(error)
    return NextResponse.json(
      { error: "An error occurred while fetching likes" },
      { status: 500 }
    )
  }
}

export async function POST(
  req: Request,
  { params }: { params: { id: string } }
) {
  const body = await req.json()
  const { userId } = body

  const { searchParams } = new URL(req.url)
  const postId = searchParams.get("id") || params.id

  let like

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "Missing required fields" },
        { status: 400 }
      )
    }

    const existingLike = await db.likes.findFirst({
      where: {
        postId: postId,
        userId: userId,
      },
    })

    if (existingLike) {
      like = await db.likes.delete({
        where: {
          id: existingLike.id,
        },
      })
    } else {
      like = await db.likes.create({
        data: {
          userId: userId,
          postId: postId,
        },
      })
    }

    return NextResponse.json(
      {
        message: existingLike
          ? "Post unliked successfully"
          : "Post liked successfully",
        like,
      },
      { status: 200 }
    )
  } catch (error) {
    console.error(error)
    return NextResponse.json(
      { error: "An error occurred while creating like" },
      { status: 500 }
    )
  }
}
