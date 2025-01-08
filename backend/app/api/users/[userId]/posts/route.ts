import db from "@/lib/db";
import { Prisma } from "@prisma/client";
import { NextResponse } from "next/server";

export async function GET(
  req: Request,
  props: { params: Promise<{ userId: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const userId = searchParams.get("userId") || params.userId;

  try {
    const posts = await db.post.findMany({
      where: {
        userId: userId, // Filter posts based on userId
      },
      include: {
        Schedule: true,
        user: true,
        koas: true,
        treatment: true,
        likes: true,
      },
      orderBy: {
        createdAt: "desc",
      },
    });
    
    if (!posts || posts.length === 0) {
      return NextResponse.json(
        { error: "No posts found for this user" },
        { status: 404 }
      );
    }

    // Count the likes for each post
    const postsWithLikeCount = await Promise.all(
      posts.map(async (post) => {
        const likeCount = await db.like.count({
          where: {
            postId: post.id,
          },
        });
        return { ...post, likeCount };
      })
    );

    return NextResponse.json({ posts: postsWithLikeCount });
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error: "An error occurred while fetching posts for the user" },
      { status: 500 }
    );
  }
}

export async function PATCH(
  req: Request,
  props: { params: Promise<{ postId: string; userId: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const postId = searchParams.get("postId") || params.postId;
  const userId = searchParams.get("userId") || params.userId;

  const body = await req.json();
  const {
    koasId,
    title,
    desc,
    patientRequirement,
    status,
    published,
    treatmentId,
  } = body;

  try {
    // Check if the post belongs to the user
    const post = await db.post.findFirst({
      where: { id: postId, userId: userId },
    });

    if (!post) {
      return NextResponse.json(
        { error: "Post not found or not authorized" },
        { status: 404 }
      );
    }

    const updatedPost = await db.post.update({
      where: { id: postId },
      data: {
        title: title ?? post.title,
        desc: desc ?? post.desc,
        patientRequirement: patientRequirement ?? post.patientRequirement,
        status: status ?? post.status,
        published: published ?? post.published,
        treatmentId: treatmentId ?? post.treatmentId,
        koas: koasId ? { connect: { id: String(koasId) } } : undefined,
      } as Prisma.PostUpdateInput,
    });

    return NextResponse.json(updatedPost, { status: 200 });
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error: "An error occurred while updating the post" },
      { status: 500 }
    );
  }
}

export async function PUT(
  req: Request,
  props: { params: Promise<{ postId: string; userId: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const postId = searchParams.get("postId") || params.postId;
  const userId = searchParams.get("userId") || params.userId;

  const body = await req.json();
  const {
    koasId,
    title,
    desc,
    patientRequirement,
    status,
    published,
    treatmentId,
  } = body;

  try {
    // Ensure the post exists and belongs to the user
    const post = await db.post.findFirst({
      where: { id: postId, userId: userId },
    });

    if (!post) {
      return NextResponse.json(
        { error: "Post not found or not authorized" },
        { status: 404 }
      );
    }

    const updatedPost = await db.post.update({
      where: { id: postId },
      data: {
        title,
        desc,
        patientRequirement,
        status,
        published,
        treatmentId: String(treatmentId),
        user: { connect: { id: String(userId) } },
        koas: { connect: { id: String(koasId) } },
      } as Prisma.PostUpdateInput,
    });

    return NextResponse.json(updatedPost, { status: 200 });
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error: "An error occurred while updating the post" },
      { status: 500 }
    );
  }
}

export async function DELETE(
  req: Request,
  props: { params: Promise<{ postId: string; userId: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const postId = searchParams.get("postId") || params.postId;
  const userId = searchParams.get("userId") || params.userId;

  try {
    // Check if the post belongs to the user
    const post = await db.post.findFirst({
      where: { id: postId, userId: userId },
    });

    if (!post) {
      return NextResponse.json(
        { error: "Post not found or not authorized" },
        { status: 404 }
      );
    }

    await db.post.delete({
      where: { id: postId },
    });

    return NextResponse.json(
      { message: "Post deleted successfully" },
      { status: 200 }
    );
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error: "An error occurred while deleting the post" },
      { status: 500 }
    );
  }
}
