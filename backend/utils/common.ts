let currentCounters: Record<string, number> = {}; // Penyimpanan sementara untuk nilai otomatis

/**
 * Fungsi untuk membuat ID dengan format tertentu
 * @param prefix - Prefix untuk ID (misalnya "U")
 * @param autoIncrement - Apakah ID harus diinkrementasi otomatis
 * @param startValue - Nilai awal untuk ID (misalnya 1)
 * @returns ID yang dihasilkan (misalnya "U001")
 */
function genId(prefix: string, autoIncrement = true, startValue = 1): string {
  if (!currentCounters[prefix]) {
    currentCounters[prefix] = startValue - 1; // Set nilai awal jika belum ada
  }

  if (autoIncrement) {
    currentCounters[prefix]++;
  }

  const numericPart = currentCounters[prefix].toString().padStart(4, "0");
  return `${prefix}${numericPart}`;
}
