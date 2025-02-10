import db from "@/lib/db";
import { NextResponse } from "next/server";

export async function GET(
  req: Request,
  props: { params: Promise<{ postId: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const postId = searchParams.get("postId") || params.postId;

  // Mengambil userId dari body request (pastikan body parsing diaktifkan jika diperlukan)
  let body;
  try {
    body = await req.json();
  } catch {
    return NextResponse.json({ error: "Invalid JSON input" }, { status: 400 });
  }
  const { userId } = body;

  if (!userId) {
    return NextResponse.json({ error: "Missing userId" }, { status: 400 });
  }

  try {
    // Memeriksa apakah user sudah menyukai postingan
    const existingLike = await db.like.findUnique({
      where: {
        id: `${userId}_${postId}`,
      },
    });

    // Mengembalikan respons berdasarkan status like
    return NextResponse.json(
      {
        isLiked: existingLike !== null, // Jika ada like, berarti user sudah menyukai postingan
      },
      { status: 200 }
    );
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error: "An error occurred while fetching Like" },
      { status: 500 }
    );
  }
}
