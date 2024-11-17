import { PrismaClient } from "@prisma/client";
import bcrypt from "bcryptjs";
// import { createSeedClient } from "@snaplet/seed";
import { Role } from "@/config/enum";
import { users } from "@/data/users";

const prisma = new PrismaClient();

async function main() {
  // Truncate all tables in the database
  // const seed = await createSeedClient();
  // await seed.$resetDatabase()

  for (const user of users) {
    const hash = await bcrypt.hash(user.password, 10);

    // Create user
    const createdUser = await prisma.user.create({
      data: {
        ...user,
        givenName: `${user.givenName}.${user.familyName}`,
        password: hash,
      },
    });

    if (user.role === Role.Koas) {
      // Create koas
      await prisma.KoasProfile.create({
        data: {
          userId: createdUser.id,
        },
      });
    } else if (user.role === Role.Pasien) {
      // Create pasien
      await prisma.PasienProfile.create({
        data: {
          userId: createdUser.id,
        },
      });
    }
  }

  console.log("Data seed added:", users);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
