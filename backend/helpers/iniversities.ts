type UniversityQueryString = {
  [key: string]: string;
};

function parseSearchParams(
  searchParams: URLSearchParams
): UniversityQueryString {
  const query: UniversityQueryString = {};
  searchParams.forEach((value, key) => {
    query[key] = value;
  });
  return query;
}
