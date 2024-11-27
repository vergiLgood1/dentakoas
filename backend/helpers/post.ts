import { PostQueryString } from "@/config/types";
import { getDateRange } from "@/utils/dateTime";

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
