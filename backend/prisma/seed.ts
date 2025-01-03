import { PrismaClient } from "@prisma/client";
import bcrypt from "bcryptjs";
import { createSeedClient } from "@snaplet/seed";
import { Role } from "@/config/enum";
import { users } from "@/data/users";
import { TreatmentTypes } from "@/data/treatment-type";

const prisma = new PrismaClient();

async function main() {
  // Truncate all tables in the database
  // const seed = await createSeedClient();
  // await seed.$resetDatabase()

  // for (const user of users) {
  //   const hash = await bcrypt.hash(user.password, 10);

  //   // Create user
  //   const createdUser = await prisma.user.create({
  //     data: {
  //       ...user,
  //       name: `${user.givenName}.${user.familyName}`,
  //       password: hash,
  //     },
  //   });

  //   if (user.role === Role.Koas) {
  //     // Create koas
  //     await prisma.koasProfile.create({
  //       data: {
  //         userId: createdUser.id,
  //       },
  //     });
  //   } else if (user.role === Role.Pasien) {
  //     // Create pasien
  //     await prisma.pasienProfile.create({
  //       data: {
  //         userId: createdUser.id,
  //       },
  //     });
  //   }
  // }

  // for (const treatmentType of TreatmentTypes) {
  //   const createdTreatmentType = await prisma.treatmentType.create({
  //     data: {
  //       ...treatmentType,
  //       name: treatmentType.name,
  //     },
  //   });
  // }

  const universities = [
    {
      name: "Universitas Indonesia",
      alias: "UI",
      location: "Depok, Jawa Barat",
    },
    {
      name: "Institut Teknologi Bandung",
      alias: "ITB",
      location: "Bandung, Jawa Barat",
    },
    { name: "Universitas Gadjah Mada", alias: "UGM", location: "Yogyakarta" },
    {
      name: "Institut Pertanian Bogor",
      alias: "IPB",
      location: "Bogor, Jawa Barat",
    },
    {
      name: "Universitas Airlangga",
      alias: "UNAIR",
      location: "Surabaya, Jawa Timur",
    },
    {
      name: "Universitas Brawijaya",
      alias: "UB",
      location: "Malang, Jawa Timur",
    },
    {
      name: "Universitas Diponegoro",
      alias: "UNDIP",
      location: "Semarang, Jawa Tengah",
    },
    {
      name: "Universitas Padjadjaran",
      alias: "UNPAD",
      location: "Bandung, Jawa Barat",
    },
    {
      name: "Universitas Sebelas Maret",
      alias: "UNS",
      location: "Surakarta, Jawa Tengah",
    },
    {
      name: "Universitas Sumatera Utara",
      alias: "USU",
      location: "Medan, Sumatera Utara",
    },
    {
      name: "Politeknik Negeri Jember",
      alias: "POLIJE",
      location: "Jember, Jawa Timur",
    },
    {
      name: "Universitas Negeri Jember",
      alias: "UNEJ",
      location: "Jember, Jawa Timur",
    },
    // Tambahkan lebih banyak universitas sesuai kebutuhan
  ];

  // Menggunakan createMany untuk menambahkan banyak entri sekaligus
  await prisma.university.createMany({
    data: universities,
    skipDuplicates: true, // Menghindari error jika data sudah ada
  });

  console.log("Seeded universities successfully." + universities);

  // console.log("Data seed added:", TreatmentTypes);
}

main()
  .catch((e) => {
    console.error(e);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });
