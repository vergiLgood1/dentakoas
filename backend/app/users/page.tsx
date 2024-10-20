// app/users/page.tsx
'use client'

import React, { useState, useEffect } from "react"
import { Card } from "@/components/ui/card"

const UsersPage = () => {
  const [users, setUsers] = useState<any[]>([])
  const [loading, setLoading] = useState<boolean>(true)
  const [error, setError] = useState<string>("")

  useEffect(() => {
    const fetchUsers = async () => {
      try {
        const response = await fetch("/api/users")
        const data = await response.json()

        if (response.ok) {
          setUsers(data)
          setError("")
        } else {
          setError(data.error || "Failed to fetch users")
        }
      } catch (err) {
        setError("Error fetching users")
      } finally {
        setLoading(false)
      }
    }

    fetchUsers()
  }, [])

  return (
    <div className="container mx-auto py-10">
      <Card>
        <h2 className="text-2xl font-bold mb-4">Users List</h2>
        {loading ? (
          <p>Loading...</p>
        ) : error ? (
          <p className="text-red-500">{error}</p>
        ) : (
          <pre className="whitespace-pre-wrap">{JSON.stringify(users, null, 2)}</pre>
        )}
      </Card>
    </div>
  )
}

export default UsersPage
