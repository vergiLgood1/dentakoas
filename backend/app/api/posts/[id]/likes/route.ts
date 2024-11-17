import db from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET(
  req: Request,
  { params }: { params: { id: string } }
) {
  const { searchParams } = new URL(req.url);
  const postId = searchParams.get("id") || params.id;

  try {
    const Like = await db.Like.findMany({
      where: { postId: postId },
      include: {
        user: {
          select: {
            id: true,
            name: true,
            email: true,
            image: true,
            createdAt: true,
          },
        },
      },
      orderBy: {
        userId: "asc",
      },
    });

    if (!Like) {
      return NextResponse.json({ error: "Like not found" }, { status: 404 });
    }

    const user = Like.map((like) => like.user);
    return NextResponse.json(user, { status: 200 });
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error: "An error occurred while fetching Like" },
      { status: 500 }
    );
  }
}

export async function POST(
  req: Request,
  { params }: { params: { id: string } }
) {
  const body = await req.json();
  const { userId } = body;

  const { searchParams } = new URL(req.url);
  const postId = searchParams.get("id") || params.id;

  let like;

  try {
    if (!userId) {
      return NextResponse.json(
        { error: "Missing required fields" },
        { status: 400 }
      );
    }

    const existingLike = await db.Like.findFirst({
      where: {
        postId,
        userId,
      },
    });

    if (existingLike) {
      like = await db.Like.delete({
        where: {
          id: existingLike.id,
        },
      });
    } else {
      like = await db.Like.create({
        data: {
          userId,
          postId,
        },
      });
    }

    return NextResponse.json(
      {
        message: existingLike
          ? "Post unliked successfully"
          : "Post liked successfully",
        like,
      },
      { status: 200 }
    );
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error: "An error occurred while creating like" },
      { status: 500 }
    );
  }
}
