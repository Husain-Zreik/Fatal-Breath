import { Features, Hero, Purpose, UserTypes } from '@/components'

export default function Home() {
  return (
    <main className="overflow-hidden ">
      <Hero/>
      <Purpose/>
      <UserTypes/>
      <Features/>
    </main>
  )
}
