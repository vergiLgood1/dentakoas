import { PostQueryString } from "@/config/types";
import db from "@/lib/db";
import { formatDate, getDateRange } from "@/utils/dateTime";
import { format } from "date-fns";
import { NextResponse } from "next/server";

export function parseSearchParamsPost(
  searchParams: URLSearchParams
): PostQueryString {
  const queStr: PostQueryString = {};

  searchParams.forEach((value, key) => {
    if (key === "createdAt" || key === "updatedAt") {
      const dateRange = getDateRange(value);

      if (dateRange) queStr[key] = dateRange; // Gunakan objek langsung, bukan string
    } else {
      queStr[key] = value;
    }
  });

  return queStr;
}

export async function updateExpiredPosts() {
  try {
    // Get today's date
    const today = new Date();

    console.log("Today's date:", today);

    // Find all posts with status "Open" that have expired
    const post = await db.post.findMany({
      where: {
        status: "Open",
      },
      include: {
        Schedule: true,
      },
    });
    const expiredPosts = post.filter((post) => {
      return post.Schedule.some(
        (schedule) => new Date(schedule.dateEnd) < today
      );
    });

    console.log("Processing expired posts:", expiredPosts.length);

    // Update status post to "Closed"
    const updateResults = await db.post.updateMany({
      where: {
        id: { in: expiredPosts.map((post) => post.id) },
      },
      data: {
        status: "Closed",
      },
    });

    // Send notifications
    const sendNotification = await db.notification.createMany({
      data: expiredPosts.map((post) => ({
        title: "Post Expired",
        message: `Your post created on ${formatDate(
          post.createdAt,
          "dd MMMM yyyy"
        )} with the title"${
          post.title
        }" has expired and automatically closed.`,
        userId: post.userId,
      })),
    });

    console.log(
      `${updateResults.count} expired posts updated to "Closed". ${sendNotification.count} notifications sent.`
    );

    // return NextResponse.json({
    //   status: "Success",
    //   message: "Expired post updated successfully",
    //   data: {
    //     updateResults,
    //     sendNotification,
    //   },
    // });
  } catch (error) {
    if (error instanceof Error) {
      console.log("Error: ", error.stack);
    }
  }
}