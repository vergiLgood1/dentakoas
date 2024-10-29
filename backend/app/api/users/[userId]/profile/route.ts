import { NextResponse } from "next/server"
import db from "@/lib/db"
import { Role } from "@/config/types"

export async function GET(
  req: Request,
  { params }: { params: { userId: string } }
) {
  const userId = params.userId
  let profile

  if (!userId) {
    return NextResponse.json({ error: "User ID is required" }, { status: 400 })
  }

  try {
    // Fetch the user, including the role and relevant profiles
    const user = await db.users.findUnique({
      where: { id: userId },
      select: {
        id: true,
        username: true,
        email: true,
        phone: true,
        address: true,
        img: true,
        role: true,
      },
    })

    if (!user) {
      return NextResponse.json({ error: "User not found" }, { status: 404 })
    }

    // Check user role and respond with the appropriate profile
    if (user.role === Role.Koas) {
      profile = await db.koasProfile.findUnique({
        where: { userId },
        select: {
          id: true,
          userId: true,
          koasNumber: true,
          faculty: true,
          bio: true,
          whatsappLink: true,
          status: true,
        },
      })
    } else if (user.role === Role.Pasien) {
      profile = await db.pasienProfile.findUnique({
        where: { userId },
        select: {
          id: true,
          userId: true,
          age: true,
          gender: true,
          bio: true,
        },
      })
    } else {
      return NextResponse.json({ error: "Invalid user role" }, { status: 400 })
    }

    if (!profile) {
      return NextResponse.json({ error: "Profile not found" }, { status: 404 })
    }

    const userWithProfile = {
      ...user,
      profile,
    }

    return NextResponse.json(
      { message: "Fetch user profile successfully", user: userWithProfile },
      { status: 200 }
    )
  } catch (error) {
    console.error("Error fetching profile:", error)
    return NextResponse.json(
      { error: "Error fetching profile" },
      { status: 500 }
    )
  }
}

