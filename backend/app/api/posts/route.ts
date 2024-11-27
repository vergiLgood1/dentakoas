import { NextResponse } from "next/server";
import db from "@/lib/db";
import { parseSearchParamsPost } from "@/helpers/post";
import { Prisma } from "@prisma/client";
import { StatusKoas } from "@/config/enum";
import { genSchedules, genTimeSlots } from "@/utils/dateTime";

export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const queStr = parseSearchParamsPost(searchParams);

  try {
    const posts = await db.post.findMany({
      where: {
        ...queStr,
      } as Prisma.PostWhereInput,
      include: {
        Schedule: {
          select: {
            id: true,
            dateStart: true,
            dateEnd: true,
            timeslot: {
              select: {
                id: true,
                startTime: true,
                endTime: true,
                maxParticipants: true,
                currentParticipants: true,
                isAvailable: true,
              },
            },
          },
        },
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

export async function POST(
  req: Request,
  { params }: { params: { id: string } }
) {
  const body = await req.json();
  const {
    userId,
    koasId,
    treatmentId,
    title,
    desc,
    patientRequirement,
    requiredParticipant,
    dateRangeStart,
    dateRangeEnd,
    published,
    status,
    koasStartTime, // Waktu mulai koas
    koasEndTime, // Waktu selesai koas
  } = body;

  try {
    if (!userId || !koasId || !treatmentId || !title || !desc) {
      return NextResponse.json(
        { error: "Missing required fields" },
        { status: 400 }
      );
    }

    const koasProfile = await db.koasProfile.findUnique({
      where: { id: koasId },
      select: {
        status: true,
      },
    });

    if (!koasProfile) {
      return NextResponse.json(
        { error: "Koas Profile not found" },
        { status: 404 }
      );
    }

    if (koasProfile.status !== StatusKoas.Approved) {
      return NextResponse.json(
        { error: "Don't have access to post before status approved" },
        { status: 400 }
      );
    }

    // Membuat Post terlebih dahulu
    const post = await db.post.create({
      data: {
        title,
        desc,
        patientRequirement,
        requiredParticipant,
        status,
        published,
        user: { connect: { id: String(userId) } },
        koas: { connect: { id: String(koasId) } },
        treatmentId: String(treatmentId),
      } as Prisma.PostCreateInput,
    });

    // // Generate jadwal berdasarkan dateRangeStart hingga dateRangeEnd
    // const scheduleDates = genSchedules(
    //   new Date(dateRangeStart),
    //   new Date(dateRangeEnd)
    // );

    // // Create schedules first using createMany
    // const schedulesData = scheduleDates.map((scheduleDate) => ({
    //   date: scheduleDate,
    //   postId: post.id,
    // }));

    // await db.schedule.createMany({
    //   data: schedulesData,
    // });

    return NextResponse.json(
      {
        status: "Success",
        message: "Posts retrieved successfully",
        data: { posts: post },
      },
      { status: 200 }
    );
  } catch (error) {
    console.error(error);
    return NextResponse.json(
      { error: "An error occurred while creating the post" },
      { status: 500 }
    );
  }
}
