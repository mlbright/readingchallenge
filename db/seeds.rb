# Clear existing data
puts "Clearing existing data..."
Vote.destroy_all
Book.destroy_all
ChallengeParticipation.destroy_all
Challenge.destroy_all
User.destroy_all

puts "Creating users..."

# Create site administrator with strong password
admin = User.create!(
  username: "admin",
  email: "admin@readingchallenge.com",
  password: "Admin123!@#Strong",
  password_confirmation: "Admin123!@#Strong",
  admin: true
)

# Create regular users with strong passwords
alice = User.create!(
  username: "alice",
  email: "alice@example.com",
  password: "Alice123!@#Pass",
  password_confirmation: "Alice123!@#Pass",
  admin: false
)

bob = User.create!(
  username: "bob",
  email: "bob@example.com",
  password: "Bob456!@#Pass",
  password_confirmation: "Bob456!@#Pass",
  admin: false
)

charlie = User.create!(
  username: "charlie",
  email: "charlie@example.com",
  password: "Charlie789!@#Pass",
  password_confirmation: "Charlie789!@#Pass",
  admin: false
)

# Create a user without password (needs to set up on first login)
diana = User.new(
  username: "diana",
  email: "diana@example.com",
  admin: false
)
diana.password_digest = nil
diana.save(validate: false)

puts "Created #{User.count} users"

puts "\nCreating challenges..."

# Challenge 1: Summer Reading 2025 (active, low threshold)
summer_challenge = Challenge.create!(
  name: "Summer Reading Challenge 2025",
  description: "Read as many books as you can this summer! Let's make it a great season of reading.",
  due_date: Date.today + 90.days,
  veto_threshold: 2,
  creator: alice
)

# Challenge 2: Sci-Fi Marathon (active, high threshold)
scifi_challenge = Challenge.create!(
  name: "Sci-Fi Marathon",
  description: "Dive into science fiction classics and modern hits. From space operas to dystopian futures!",
  due_date: Date.today + 60.days,
  veto_threshold: 1,
  creator: bob
)

# Challenge 3: Non-Fiction November (ending soon)
nonfiction_challenge = Challenge.create!(
  name: "Non-Fiction November",
  description: "Expand your knowledge with non-fiction books. History, science, biography, and more!",
  due_date: Date.today + 14.days,
  veto_threshold: 1,
  creator: charlie
)

# Challenge 4: Completed Challenge
completed_challenge = Challenge.create!(
  name: "Spring Reading Sprint (Complete)",
  description: "Our first completed challenge! Congratulations to all participants.",
  due_date: Date.today - 7.days,
  veto_threshold: 2,
  creator: admin
)

puts "Created #{Challenge.count} challenges"

puts "\nAdding participants to challenges..."

# Summer Challenge participants
[ alice, bob, charlie ].each { |user| summer_challenge.participants << user }

# Sci-Fi Challenge participants
[ bob, alice, charlie ].each { |user| scifi_challenge.participants << user }

# Non-Fiction Challenge participants
[ charlie, alice, bob ].each { |user| nonfiction_challenge.participants << user }

# Completed Challenge participants
[ admin, alice, bob, charlie ].each { |user| completed_challenge.participants << user }

puts "\nAdding books to challenges..."

# Summer Challenge Books
book1 = Book.create!(
  title: "The Great Gatsby",
  author: "F. Scott Fitzgerald",
  pages: 180,
  description: "A classic American novel about the Jazz Age.",
  user: alice,
  challenge: summer_challenge,
  completion_date: Date.today - 30.days
)

book2 = Book.create!(
  title: "To Kill a Mockingbird",
  author: "Harper Lee",
  pages: 324,
  description: "A gripping tale of racial injustice and childhood innocence.",
  user: bob,
  challenge: summer_challenge,
  completion_date: Date.today - 15.days
)

book3 = Book.create!(
  title: "1984",
  author: "George Orwell",
  pages: 328,
  description: "A dystopian social science fiction novel.",
  user: charlie,
  challenge: summer_challenge,
  completion_date: nil
)

book4 = Book.create!(
  title: "Pride and Prejudice",
  author: "Jane Austen",
  pages: 432,
  description: "A romantic novel of manners.",
  user: alice,
  challenge: summer_challenge,
  completion_date: Date.today - 45.days
)

# Sci-Fi Challenge Books
book5 = Book.create!(
  title: "Dune",
  author: "Frank Herbert",
  pages: 688,
  description: "A science fiction novel set in the distant future.",
  user: bob,
  challenge: scifi_challenge,
  completion_date: Date.today - 20.days
)

book6 = Book.create!(
  title: "The Foundation",
  author: "Isaac Asimov",
  pages: 255,
  description: "The first book in the Foundation series.",
  user: alice,
  challenge: scifi_challenge,
  completion_date: nil
)

book7 = Book.create!(
  title: "Neuromancer",
  author: "William Gibson",
  pages: 271,
  description: "A cyberpunk novel and winner of the Hugo Award.",
  user: charlie,
  challenge: scifi_challenge,
  completion_date: Date.today - 10.days
)

# Non-Fiction Challenge Books
book8 = Book.create!(
  title: "Sapiens",
  author: "Yuval Noah Harari",
  pages: 443,
  description: "A brief history of humankind.",
  user: charlie,
  challenge: nonfiction_challenge,
  completion_date: Date.today - 7.days
)

book9 = Book.create!(
  title: "Educated",
  author: "Tara Westover",
  pages: 334,
  description: "A memoir about a woman who grows up in a strict household.",
  user: alice,
  challenge: nonfiction_challenge,
  completion_date: Date.today - 5.days
)

# Completed Challenge Books
book10 = Book.create!(
  title: "The Hobbit",
  author: "J.R.R. Tolkien",
  pages: 310,
  description: "A fantasy novel and prelude to The Lord of the Rings.",
  user: admin,
  challenge: completed_challenge,
  completion_date: Date.today - 60.days
)

book11 = Book.create!(
  title: "Harry Potter and the Sorcerer's Stone",
  author: "J.K. Rowling",
  pages: 309,
  description: "The first book in the Harry Potter series.",
  user: alice,
  challenge: completed_challenge,
  completion_date: Date.today - 55.days
)

book12 = Book.create!(
  title: "The Lord of the Rings",
  author: "J.R.R. Tolkien",
  pages: 1178,
  description: "An epic high-fantasy novel.",
  user: bob,
  challenge: completed_challenge,
  completion_date: Date.today - 50.days
)

book13 = Book.create!(
  title: "The Chronicles of Narnia",
  author: "C.S. Lewis",
  pages: 767,
  description: "A series of seven fantasy novels.",
  user: charlie,
  challenge: completed_challenge,
  completion_date: Date.today - 45.days
)

puts "Created #{Book.count} books across all challenges"

puts "\nAdding vetos with reasons..."

# Veto on book3 (1984 in Summer Challenge) - doesn't meet threshold
Vote.create!(
  user: bob,
  book: book3,
  veto_reason: "This book is too dark and depressing for a summer reading challenge. I think we should focus on lighter, more uplifting reads during the summer months."
)

# Veto on book6 (Foundation in Sci-Fi Challenge) - meets threshold (1 veto)
Vote.create!(
  user: charlie,
  book: book6,
  veto_reason: "While this is a classic, it's quite dated and the writing style might not appeal to modern readers. The pacing is slow and there's minimal character development."
)

# Veto on book9 (Educated) - doesn't meet threshold yet
Vote.create!(
  user: bob,
  book: book9,
  veto_reason: "This memoir contains disturbing content about abuse that may be triggering for some readers. Consider adding a content warning or choosing a different non-fiction book."
)

# Multiple vetos on book12 (LOTR) - exceeds threshold
Vote.create!(
  user: alice,
  book: book12,
  veto_reason: "The length of this book is excessive for a casual reading challenge. At over 1000 pages, it gives an unfair advantage and discourages participation from those with less free time."
)

Vote.create!(
  user: charlie,
  book: book12,
  veto_reason: "I agree with Alice. This should have been split into the individual volumes for fairness. It's essentially three books counted as one."
)

puts "Created #{Vote.count} vetos with detailed reasons"

puts "\n✅ Seed data complete!"
puts "\n📊 Summary:"
puts "  Users: #{User.count} (#{User.where(admin: true).count} admin)"
puts "  Challenges: #{Challenge.count} (#{Challenge.where('due_date >= ?', Date.today).count} active)"
puts "  Books: #{Book.count} (#{Book.where.not(completion_date: nil).count} completed)"
puts "  Vetos: #{Vote.count}"
puts "\n🔐 Login credentials:"
puts "  Admin: admin@readingchallenge.com / Admin123!@#Strong"
puts "  Alice: alice@example.com / Alice123!@#Pass"
puts "  Bob: bob@example.com / Bob456!@#Pass"
puts "  Charlie: charlie@example.com / Charlie789!@#Pass"
puts "  Diana: diana@example.com / (no password - first login setup)"
