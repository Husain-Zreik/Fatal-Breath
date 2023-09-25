import { Footer, NavBar } from '@/components'
import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'Fatal Breath',
  description: 'Protect Your Family Where They Live and Play',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
      <body className="relative ">
        <NavBar/>
        {children}
        <Footer/>
        </body>
    </html>
  )
}
