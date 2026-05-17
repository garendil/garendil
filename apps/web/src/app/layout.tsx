import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
  title: 'Garendil — Transparencia de funcionarios peruanos',
  description:
    'Sistema público de scoring de idoneidad y riesgo de corrupción para funcionarios del Estado peruano.',
  openGraph: {
    title: 'Garendil',
    description: 'Transparencia para el Estado peruano.',
    type: 'website',
  },
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="es" suppressHydrationWarning>
      <body>{children}</body>
    </html>
  )
}
