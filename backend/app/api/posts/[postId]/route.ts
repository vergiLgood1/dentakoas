import { NextResponse } from "next/server";
import db from "@/lib/db";
import { StatusKoas } from "@/config/enum";
import { Prisma } from "@prisma/client";

export async function GET(req: Request, props: { params: Promise<{ postId: string }> }) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const postId = searchParams.get("postId") || params.postId;

  try {
    const post = await db.post.findUnique({
      where: {
        id: postId,
      },
      include: {
        Schedule: true,
        user: true,
        koas: true,
        treatment: true,
        likes: true,
      },
    });

    // if (!post) {
    //   return NextResponse.json({ error: "Post not found" }, { status: 404 });
    // }

    const likeCount = await db.like.count({
      where: {
        postId,
      },
    });

    const postWithLikeCount = post
      ? {
          ...post,
          likeCount,
        }
      : [];

    return NextResponse.json({ posts: postWithLikeCount });
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error: "An error occurred while fetching the post" },
      { status: 500 }
    );
  }
}

export async function PATCH(req: Request, props: { params: Promise<{ postId: string }> }) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const postId = searchParams.get("postId") || params.postId;

  const body = await req.json();
  const {
    userId,
    koasId,
    title,
    desc,
    patientRequirement,
    status,
    published,
    treatmentId,
  } = body;

  try {
    const post = await db.post.findUnique({
      where: { id: postId },
    });

    if (!post) {
      return NextResponse.json({ error: "Post not found" }, { status: 404 });
    }

    const updatedPost = await db.post.update({
      where: { id: postId },
      data: {
        title: title ?? post.title, // Jika title ada di body, ganti, jika tidak gunakan data lama
        desc: desc ?? post.desc,
        patientRequirement: patientRequirement ?? post.patientRequirement,
        status: status ?? post.status,
        published: published ?? post.published,
        treatmentId: treatmentId ?? post.treatmentId,
        user: userId ? { connect: { id: String(userId) } } : undefined,
        koas: koasId ? { connect: { id: String(koasId) } } : undefined,
      } as Prisma.PostUpdateInput,
    });

    if (!title && !desc && !patientRequirement) {
      return NextResponse.json(
        { error: "Missing required fields" },
        { status: 400 }
      );
    }

    return NextResponse.json(updatedPost, { status: 200 });
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error: "An error occurred while updating the post" },
      { status: 500 }
    );
  }
}

export async function PUT(req: Request, props: { params: Promise<{ postId: string }> }) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const postId = searchParams.get("postId") || params.postId;

  const body = await req.json();
  const {
    userId,
    koasId,
    title,
    desc,
    patientRequirement,
    status,
    published,
    treatmentId,
  } = body;

  try {
    const post = await db.post.findUnique({
      where: { id: postId },
    });

    if (!post) {
      return NextResponse.json({ error: "Post not found" }, { status: 404 });
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

export async function DELETE(req: Request, props: { params: Promise<{ postId: string }> }) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const postId = searchParams.get("postId") || params.postId;

  try {
    const post = await db.post.findUnique({
      where: { id: postId },
    });

    if (!post) {
      return NextResponse.json({ error: "Post not found" }, { status: 404 });
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
