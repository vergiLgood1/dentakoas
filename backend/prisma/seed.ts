import { PrismaClient } from "@prisma/client"
import bcrypt from "bcryptjs"

const prisma = new PrismaClient()

async function main() {
  const passwordHash = await bcrypt.hash("password123", 12)

  await prisma.users.createMany({
    data: [
      {
        firstname: "John",
        lastname: "Doe",
        email: "john.doe@example.com",
        password: passwordHash,
        phone_number: "123456789",
        role: "PASIEN",
      },
      {
        firstname: "Jane",
        lastname: "Doe",
        email: "jane.doe@example.com",
        password: passwordHash,
        phone_number: "987654321",
        role: "PASIEN",
      },
      {
        firstname: "Admin",
        lastname: "User",
        email: "admin@example.com",
        password: passwordHash,
        phone_number: "1122334455",
        role: "KOAS",
      },
    ],
  })

  console.log("Seed data created successfully!")
}

main()
  .catch((e) => {
    console.error(e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
