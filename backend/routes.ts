/**
 * An array of routes that are accessible to the public.
 * These route do not require authentication.
 * @type {string[]}
 */
export const publicRoutes = ["/"];

/**
 * An array of routes that are used for authentication.
 * These routes will redirect logged in user to /settings.
 * @type {string[]}
 */
export const authRoutes = ["/api/auth/signin", "/api/auth/signout"];

/**
 * The prefix for API authentication routes.
 * Routes that start with this prefix are used for API authentication purpose.
 * @type {string}
 */
export const apiAuthPrefix = "/api/auth";

/**
 * An array of routes that are used for public API.
 * These routes do not require authentication.
 * @type {string[]}
 */
export const apiPublicRoutes = ["/api/users"];

/**
 * The default redirect path after loginng in.
 * @type {string}
 */
export const DEFAULT_LOGIN_REDIRECT = "/settings";

/**
 * The default redirect path after logging out.
 * @type {string}
 */
export const DEFAULT_LOGOUT_REDIRECT = "/api/auth/signin";

/**
 * The default redirect path if user access an protected routes.
 * @type {string}
 */
export const DEFAULT_PROTECTED_REDIRECT = "/api/auth/signin";
