import db from "@/lib/db"
import { NextResponse } from "next/server"
import bcrypt from "bcryptjs"
import { userValidation, validateData } from "@/utils/validation"
import { Prisma } from "@prisma/client"

export async function GET(req: Request) {
  try {
    const users = await db.users.findMany({
      include: {koas_profile: true, pasien_profile: true}
    })
    return NextResponse.json(users, { status: 200 })
  } catch (error) {
    console.error("Error fetching users", error)
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    )
  }
}

export async function POST(req: Request) {
  const body = await req.json()
  const { firstname, lastname, email, password, phone_number, role, profile } = body
  const hash = await bcrypt.hash(password, 12)

  const resValidation = validateData(userValidation, body)

  if (!resValidation.success) {
    return NextResponse.json({ error: resValidation.errors }, { status: 400 })
  }

  const existingUser = await db.users.findUnique({
    where: { email },
  })

  if (existingUser) {
    return NextResponse.json(
      { error: "Email is already registered." },
      { status: 400 }
    )
  }

  try {
    const newUser = await db.users.create({
      data: {
        firstname,
        lastname,
        email,
        password: hash,
        phone_number,
        role,
      },
    })
    return NextResponse.json(newUser, { status: 201 })
  } catch (error) {
    console.error("Error creating user", error)
    return NextResponse.json(
      { error: "Internal Server Error" },
      { status: 500 }
    )
  }
}
