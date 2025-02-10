import { NextResponse } from "next/server";
import db from "@/lib/db";

export async function GET(
  req: Request,
  props: { params: Promise<{ koasId: string }> }
) {
  const params = await props.params;
  const { searchParams } = new URL(req.url);
  const id = searchParams.get("koasId") || params.koasId;

  try {
    const koasProfile = await db.koasProfile.findUnique({
      where: {
        id: id,
      },
    });

    if (!koasProfile) {
      console.log("KoasProfile not found");
      return NextResponse.json(
        { error: "KoasProfile not found" },
        { status: 404 }
      );
    }

    return NextResponse.json(koasProfile, { status: 200 });
  } catch (error) {
    console.error("Error fetching koasProfile profile:", error); // Log error
    return NextResponse.json(
      { error: "Error fetching koasProfile profile" },
      { status: 500 }
    );
  }
}
