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
  const TreatmentTypes = [
    {
      name: "Scaling",
      alias: "scaling",
    },
    {
      name: "Penambalan Gigi",
      alias: "filling",
    },
    {
      name: "Pencabutan Gigi",
      alias: "extraction",
    },
    {
      name: "Perawatan Saluran Akar (Endodontik)",
      alias: "root canal",
    },
    {
      name: "Pemasangan Kawat Gigi Sementara",
      alias: "temporary braces",
    },
    {
      name: "Pembuatan Gigi Palsu (Prosthodontik)",
      alias: "dentures",
    },
    {
      name: "Perawatan Periodontal",
      alias: "periodontal",
    },
    {
      name: "Bleaching Gigi",
      alias: "Bleaching",
    },
    {
      name: "Pemasangan Mahkota Gigi",
      alias: "crown",
    },
    {
      name: "Operasi Gigi Bungsu",
      alias: "wisdom toothsurgery",
    },
    {
      name: "Penghalusan Akar Gigi",
      alias: "root planing",
    },
    {
      name: "Perawatan Ortodontik ",
      alias: "Aligners",
    },
    {
      name: "Perawatan Gigi Anak ",
      alias: "Pediatrik",
    },
    {
      name: "Pembuatan Inlay atau Onlay",
      alias: "inlay onlay",
    },
    {
      name: "Perawatan Gigi Sensitif",
      alias: "sensitive teeth treatment",
    },
    {
      name: "Pemeriksaan Rutin dan Konsultasi",
      alias: "routine checkup",
    },
    {
      name: "Pemasangan Sealant Gigi",
      alias: "dental sealant",
    },
    {
      name: "Perawatan Luka atau Trauma pada Gigi",
      alias: "dental trauma treatment",
    },
    {
      name: "Penghapusan Gigi Tiruan yang Rusak",
      alias: "damaged denture removal",
    },
    {
      name: "Rekonstruksi Gigi Patah",
      alias: "tooth reconstruction",
    },
  ];

  // Menggunakan createMany untuk menambahkan banyak entri sekaligus
  await prisma.treatmentType.createMany({
    data: TreatmentTypes,
    skipDuplicates: true, // Menghindari error jika data sudah ada
  });

  console.log("Seeded universities successfully." + TreatmentTypes);

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
