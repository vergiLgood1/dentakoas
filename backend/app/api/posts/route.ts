import { NextResponse } from "next/server";
import db from "@/lib/db";
import { PostQueryString } from "@/config/types";
import { parseSearchParamsPost } from "@/helpers/post";
import { Prisma } from "@prisma/client";

export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const queStr = parseSearchParamsPost(searchParams);

  try {
    const posts = await db.post.findMany({
      where: {
        ...queStr,
      } as Prisma.PostWhereInput,
      include: {
        _count: {
          select: { likes: true }, // Menghitung jumlah likes untuk setiap post
        },
      },
    });

    if (!posts.length) {
      return NextResponse.json({ error: "Post not found" }, { status: 404 });
    }

    // Map hanya untuk menambahkan properti `likeCount` tanpa `_count`
    const postsWithLikeCount = posts.map(({ _count, ...post }) => ({
      ...post,
      likes: _count.likes,
    }));

    return NextResponse.json(
      {
        status: "Success",
        message: "Posts retrieved successfully",
        data: { posts: postsWithLikeCount },
      },
      { status: 200 }
    );
  } catch (error) {
    console.error("Error fetching Posts", error);
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    );
  }
}
