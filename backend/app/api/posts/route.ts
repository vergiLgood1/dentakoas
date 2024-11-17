import { NextResponse } from "next/server";
import db from "@/lib/db";

export async function GET(req: Request) {
  try {
    const Post = await db.post.findMany();

    if (!Post) {
      return NextResponse.json({ error: "Post not found" }, { status: 404 });
    }

    const likeCount = await db.like.count();

    const PostWithLikeCount = Post.map((post) => {
      return {
        ...post,
        likeCount,
      };
    });

    return NextResponse.json(PostWithLikeCount, { status: 200 });
  } catch (error) {
    console.error("Error fetching Post", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
