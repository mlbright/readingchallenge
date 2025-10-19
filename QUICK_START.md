# Quick Start Guide

## Getting Started

### 1. Start the Application
```bash
cd /Users/mlbright/Source/readingchallenge
bin/rails server
```

Visit: `http://localhost:3000`

### 2. Create Site Administrator (First Time Only)

You'll be automatically redirected to `/admin_signup`

**Required Info**:
- Username: `admin`
- Email: `admin@example.com`
- Password: Must be 12+ chars with uppercase, lowercase, digit, and special char
- Example: `Admin123!@#Pass`

### 3. Create Users (As Admin)

1. Click **"👑 Admin"** in navigation
2. Click **"Add New User"**
3. Enter email: `user@example.com`
4. Username is auto-generated (or provide one)
5. Click **"Create User"**

### 4. Activate User Account

User visits `/activation` and enters:
- Email: `user@example.com` (provided by admin)
- Password: Create strong password

Account is immediately active!

### 5. Create a Challenge

1. Click **"Create New Challenge"**
2. Fill in:
   - **Name**: "Summer Reading 2025"
   - **Description**: Optional details
   - **End Date**: Pick a future date
   - **Veto Threshold**: 1 or 2 (how many vetos disqualify a book)
3. Click **"Create Challenge"**

### 6. Join a Challenge

1. Browse **"Available Challenges"**
2. Click **"View Details"**
3. Click **"Join Challenge"**

### 7. Add a Book

1. Open your challenge
2. Click **"Add Book"** or **"➕ Add a Book"**
3. Fill in:
   - Title: "The Great Gatsby"
   - Author: "F. Scott Fitzgerald"
   - Pages: 180
   - Completion Date: Optional (add when finished)
4. Click **"Add Book"**

### 8. Veto a Book

1. Open a book's detail page
2. Scroll to **"Veto this book"**
3. Write detailed reason (10-500 characters):
   - "This book doesn't fit the summer theme. It's too dark and focuses on tragedy rather than uplifting content suitable for beach reading."
4. Click **"🚫 Submit Veto"**

### 9. Check Leaderboard

1. Open any challenge
2. Click **"📊 View Leaderboard"**
3. See rankings:
   - **Books Completed**: Total finished
   - **Valid Books**: Count for ranking (not vetoed above threshold)

## Key Features

### Password Requirements
- ✓ 12+ characters
- ✓ Uppercase letter
- ✓ Lowercase letter
- ✓ Digit
- ✓ Special character

### Challenge Limits
- Maximum 100 challenges per user
- Configurable veto threshold per challenge
- Challenge creator has admin powers

### Veto System
- Any participant can veto any book (except their own)
- 10-500 characters required
- Public veto record
- Books exceeding threshold don't count for leaderboard

### Leaderboard
- Updates in real-time
- Shows completed vs valid books
- Winners announced when challenge ends
- Top 3 get 🥇🥈🥉 medals

## Common Tasks

### As Site Administrator

**View All Users**:
Navigation → 👑 Admin

**Create User**:
Admin → Add New User → Enter email

**Delete User**:
Admin → Users list → Delete button

### As User

**View My Challenges**:
Navigation → Challenges

**Create Challenge**:
Challenges → Create New Challenge

**Edit My Challenge**:
My Challenge → Edit button (only creator can edit)

**Leave Challenge**:
Challenge Details → Leave Challenge button

**Add Completion Date**:
My Book → Edit → Set Completion Date

**Remove My Veto**:
Book Details → Remove Veto button

## Routes Quick Reference

| Path | Purpose |
|------|---------|
| `/` | Smart home (redirects appropriately) |
| `/admin_signup` | One-time admin setup |
| `/activation` | User activation |
| `/login` | Sign in |
| `/challenges` | Browse challenges |
| `/challenges/new` | Create challenge |
| `/challenges/:id` | Challenge details |
| `/challenges/:id/leaderboard` | Rankings |
| `/admin/users` | User management (admin only) |

## Troubleshooting

**"Site administrator already exists"**
- Admin signup only works once. Use `/login` instead.

**"No account found with this email"**
- Admin must create your account first via Admin panel.

**"This account already has a password set"**
- Use `/login` instead of `/activation`.

**"Password doesn't meet requirements"**
- Check: 12+ chars, uppercase, lowercase, digit, special char
- Example: `MyPassword123!`

**"You must be a participant"**
- Join the challenge first before adding books.

**Can't edit challenge**
- Only the challenge creator can edit or delete.

**Book not counting on leaderboard**
- Check if it has vetos ≥ threshold
- Red badge shows "Exceeds Veto Threshold"

## Need Help?

1. Check README.md for detailed documentation
2. Check IMPLEMENTATION_COMPLETE.md for technical details
3. Contact your site administrator

## Development Commands

```bash
# Start server
bin/rails server

# Run migrations
bin/rails db:migrate

# Console
bin/rails console

# Run tests
bin/rails test

# Check routes
bin/rails routes

# Reset database (⚠️ destroys all data)
bin/rails db:reset
```

## Example Strong Passwords

- `Reading2025!Challenge`
- `MyBooks@Journey#123`
- `Summer#Reading$456`
- `Admin123!@#Strong`
- `Password1!ForBooks`

All meet requirements! ✓
