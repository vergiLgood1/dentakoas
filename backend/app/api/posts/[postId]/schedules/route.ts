import db from "@/lib/db";
import { NextResponse } from "next/server";

export async function POST(req: Request, props: { params: Promise<{ postId: string }> }) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const postId = searchParams.get("postId") || params.postId;

  const body = await req.json();
  const { dateStart, dateEnd } = body;

  console.log("Receive Body", body);

  try {
    const post = await db.post.findUnique({
      where: { id: postId },
      select: { id: true },
    });

    if (!post) {
      return NextResponse.json({ error: "Post not found." }, { status: 404 });
    }

    // Create schedule
    const schedule = await db.schedule.create({
      data: {
        dateStart: dateStart,
        dateEnd: dateEnd,
        post: {
          connect: {
            id: postId,
          },
        },
      },
    });

    return NextResponse.json(schedule);
  } catch (error) {
    return NextResponse.json(
      { error: "Failed to create schedule." },
      { status: 500 }
    );
  }
}
