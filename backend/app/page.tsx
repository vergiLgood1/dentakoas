"use client";

import { useState } from "react";
import Link from "next/link";
import {
  ArrowRight,
  CheckCircle,
  Code,
  Zap,
  Users,
  Calendar,
  Clock,
} from "lucide-react";

export default function WelcomePage() {
  const [email, setEmail] = useState("");

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    console.log("Submitted email:", email);
  };

  return (
    <div className="flex flex-col min-h-screen">
      <header className="sticky top-0 z-50 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60">
        <div className="container mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex h-16 items-center justify-between">
            <Link className="flex items-center space-x-2" href="#">
              <Zap className="h-6 w-6 text-black-500" />
              <span className="text-2xl font-bold">DentalAPI</span>
            </Link>
            <nav className="hidden md:flex gap-6">
              <Link
                className="text-sm font-medium hover:underline underline-offset-4"
                href="#features"
              >
                Endpoints
              </Link>
              <Link
                className="text-sm font-medium hover:underline underline-offset-4"
                href="#pricing"
              >
                Pricing
              </Link>
              <Link
                className="text-sm font-medium hover:underline underline-offset-4"
                href="#docs"
              >
                Documentation
              </Link>
            </nav>
          </div>
        </div>
      </header>

      <main className="flex-1">
        {/* Hero Section with Notion-style background */}
        <section className="relative w-full py-12 md:py-24 lg:py-32 xl:py-48 overflow-hidden">
          {/* Gradient background */}
          <div className="absolute inset-0 bg-gradient-to-br from-blue-50 via-white to-purple-50 dark:from-gray-900 dark:via-gray-800 dark:to-gray-900" />

          {/* Geometric patterns */}
          <div
            className="absolute inset-0"
            style={{
              backgroundImage: `radial-gradient(circle at 2px 2px, rgba(0,0,0,0.05) 1px, transparent 0)`,
              backgroundSize: "24px 24px",
            }}
          />

          {/* Animated gradient blobs */}
          <div className="absolute top-0 -left-4 w-72 h-72 bg-purple-300 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-blob" />
          <div className="absolute top-0 -right-4 w-72 h-72 bg-yellow-300 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-blob animation-delay-2000" />
          <div className="absolute -bottom-8 left-20 w-72 h-72 bg-blue-300 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-blob animation-delay-4000" />

          <div className="relative container mx-auto px-4 sm:px-6 lg:px-8">
            <div className="flex flex-col items-center justify-center text-center max-w-3xl mx-auto">
              <div className="inline-block mb-6">
                <span className="inline-flex items-center justify-center px-4 py-1 text-sm font-medium rounded-full bg-blue-100 text-blue-800 dark:bg-blue-900 dark:text-blue-200">
                  Frontend Developer Tools
                </span>
              </div>
              <h1 className="text-4xl font-bold tracking-tight sm:text-5xl md:text-6xl bg-clip-text text-transparent bg-gradient-to-r from-blue-600 to-purple-600 dark:from-blue-400 dark:to-purple-400">
                Dental Practice API for Frontend Developers
              </h1>
              <p className="mt-6 text-lg leading-8 text-gray-600 dark:text-gray-300 max-w-2xl">
                Seamlessly integrate appointment scheduling, patient management,
                and dental records into your frontend applications with our
                comprehensive REST API.
              </p>
              <div className="mt-10 w-full max-w-md">
                <form
                  onSubmit={handleSubmit}
                  className="flex flex-col sm:flex-row gap-3"
                >
                  <input
                    className="flex h-10 w-full rounded-md border border-input bg-white/80 dark:bg-gray-800/80 backdrop-blur-sm px-3 py-2 text-sm ring-offset-background file:border-0 file:bg-transparent file:text-sm file:font-medium placeholder:text-muted-foreground focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2"
                    placeholder="Enter your email for API key"
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    required
                  />
                  <button
                    className="inline-flex items-center justify-center whitespace-nowrap rounded-md text-sm font-medium ring-offset-background transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-ring focus-visible:ring-offset-2 disabled:pointer-events-none disabled:opacity-50 bg-blue-600 text-white hover:bg-blue-500 h-10 px-4 py-2 shadow-lg hover:shadow-xl transition-shadow duration-200"
                    type="submit"
                  >
                    Get API Key
                    <ArrowRight className="ml-2 h-4 w-4" />
                  </button>
                </form>
                <p className="mt-3 text-sm text-gray-500 dark:text-gray-400">
                  Free tier available. No credit card required.
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* Rest of the sections remain the same */}
        {/* Features Section */}
        <section
          id="features"
          className="w-full py-0 bg-gray-50 dark:bg-gray-800"
        >
          {/* ... (rest of the features section code remains unchanged) ... */}
        </section>

        {/* Pricing Section */}
        <section id="pricing" className="w-full py-0">
          {/* ... (rest of the pricing section code remains unchanged) ... */}
        </section>
      </main>

      <footer className="border-t">
        {/* ... (footer code remains unchanged) ... */}
      </footer>

      {/* Add animations */}
      <style jsx global>{`
        @keyframes blob {
          0% {
            transform: translate(0px, 0px) scale(1);
          }
          33% {
            transform: translate(30px, -50px) scale(1.1);
          }
          66% {
            transform: translate(-20px, 20px) scale(0.9);
          }
          100% {
            transform: translate(0px, 0px) scale(1);
          }
        }
        .animate-blob {
          animation: blob 7s infinite;
        }
        .animation-delay-2000 {
          animation-delay: 2s;
        }
        .animation-delay-4000 {
          animation-delay: 4s;
        }
      `}</style>
    </div>
  );
}
