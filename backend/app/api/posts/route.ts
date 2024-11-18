import { NextResponse } from "next/server";
import db from "@/lib/db";
import { PostQueryString } from "@/config/types";
import { parseSearchParams } from "@/helpers/user";

export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const queStr = parseSearchParams(searchParams);

  try {
    const existingPost = await db.post.findMany({
      where: {
        ...queStr,
        createdAt: queStr.createdAt
          ? JSON.stringify(queStr.createdAt)
          : undefined,
      },
    });

    if (!existingPost) {
      return NextResponse.json({ error: "Post not found" }, { status: 404 });
    }

    const likeCount = await db.like.count();

    const posts = existingPost.map((post) => {
      return {
        ...post,
        likeCount,
      };
    });

    return NextResponse.json(
      {
        status: "Success",
        message: "Post retrived successfully",
        data: { posts },
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error fetching Post", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
