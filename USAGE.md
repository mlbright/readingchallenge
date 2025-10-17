# Reading Challenge - User Guide# Reading Challenge - User Guide



## Quick Start## Quick Start



1. **Start the application:**1. **Start the application:**

   ```bash   ```bash

   bin/rails server   bin/rails server

   ```   ```



2. **Visit:** http://localhost:30002. **Visit:** http://localhost:3000



3. **First-time setup:**3. **Login with a sample account:**

   - Create the site administrator account (one-time only)   - Username: `admin`, Password: `password` (Administrator)

   - Admin creates user accounts   - Username: `alice`, Password: `password`

   - Users activate their accounts at `/signup`   - Username: `bob`, Password: `password`  

   - Username: `charlie`, Password: `password`

## Features Overview

## Features Overview

### 1. User Registration & Authentication

### 1. User Registration & Authentication

#### Site Administrator (First Time Only)- Click "Sign Up" to create a new account

- Visit the application - you'll be redirected to `/admin_signup`- Provide a username, email, and password

- Create the administrator account with:- Once registered, you'll be automatically logged in

  - Username

  - Email### 2. Viewing Participants

  - Strong password (12+ chars, uppercase, lowercase, digit, special char)- The home page shows all users participating in the reading challenge

- This can only be done once- Each user card displays:

  - Username

#### Admin Creating Users  - Total books read

1. Log in as administrator  - Number of approved books

2. Click "👑 Admin" in navigation  - Number of disapproved books (if any)

3. Click "Add New User"- Click "View Books" to see a user's complete reading list

4. Enter user's email (username auto-generated if not provided)

5. User account is created without password### 3. Adding Books

- Click "Add Book" in the navigation or on your profile

#### User Account Activation- Fill in the book details:

1. Visit `/signup`  - **Title** (required): The book's title

2. Enter email provided by administrator  - **Author** (required): The book's author

3. Create a strong password  - **Pages** (required): Number of pages

4. Account is immediately active  - **Description** (optional): A brief description of the book

  - **URL** (optional): Link to Amazon, Goodreads, or another bookstore

### 2. Challenges

### 4. Viewing Books

#### Viewing Challenges- **All Books**: See every book added by all participants

The Challenges page shows three sections:- **User Profile**: View a specific user's reading list

- **My Challenges**: Challenges you created- **Book Details**: Click on any book title to see full details including:

- **Participating**: Challenges you've joined  - Complete book information

- **Available**: Challenges you can join  - Purchase/info link (if provided)

  - All votes from other users

Each challenge card displays:  - Approval status

- Challenge name and description

- Creator### 5. Voting System

- Due date and time remaining- You can vote on any book except your own

- Number of participants- Two voting options:

- Veto threshold  - **👍 Approve**: You think the book is valid for the challenge

- Status badges (Active/Complete, Creator/Participant)  - **👎 Disapprove**: You don't think the book should count



#### Creating a Challenge#### How Majority Voting Works:

1. Click "Create New Challenge"- If **more than half** of other users disapprove a book, it's marked as "Disapproved by Majority"

2. Fill in details:- For example, with 3 total users:

   - **Name** (required): Your challenge name  - Book owner: 1 user (cannot vote on their own book)

   - **Description** (optional): Details about the challenge  - Other users: 2 users

   - **Due Date** (required): When the challenge ends  - If 2 users disapprove (more than half of 2), the book is disapproved

   - **Veto Threshold** (required): How many vetos disqualify a book

3. Click "Create Challenge"- Disapproved books:

4. You're automatically added as a participant  - Show a warning badge (⚠️)

  - Are highlighted in red in lists

#### Inviting Users to Your Challenge  - Still count in the user's total but are separately tracked

1. Open your challenge (must be creator)

2. Click "👥 Invite Users"### 6. Managing Your Books

3. Select users from the checkbox listOn your own books, you can:

4. Click "Add Selected Users"- **Edit**: Update any book details

5. Users are immediately added and can participate- **Delete**: Remove a book from your reading list



#### Joining a Challenge### 7. User Statistics

1. Browse "Available Challenges"Each user's profile shows:

2. Click "View Details" on any challenge- **Total Books**: All books added

3. Click "Join Challenge"- **Approved**: Books not disapproved by the majority

4. You can now add books to this challenge- **Disapproved by Majority**: Books that more than half of users disapproved



#### Leaving a Challenge## Navigation

1. Open a challenge you're participating in

2. Click "Leave Challenge"- **Reading Challenge** (logo): Go to home page (all users)

3. Confirm (you cannot leave if you're the creator)- **All Users**: View all participants

- **All Books**: Browse all books in the challenge

### 3. Books- **Add Book**: Add a new book to your list

- **My Profile**: View your own reading list

#### Adding Books- **Logout**: Sign out of your account

1. Join or create a challenge

2. Click "Add Book" or "➕ Add a Book"## Tips

3. Fill in book details:

   - **Title** (required): The book's title1. **Be honest with voting**: The goal is to maintain integrity in the reading challenge

   - **Author** (required): The book's author2. **Add descriptions**: Help others understand why you liked a book

   - **Pages** (required): Number of pages3. **Include URLs**: Make it easy for others to find and purchase books they're interested in

   - **Description** (optional): Brief description4. **Check the All Books page**: Discover what others are reading

   - **URL** (optional): Link to Amazon, Goodreads, etc.5. **Vote on books**: Participate in the community by reviewing others' books

   - **Completion Date** (optional): When you finished it

4. Click "Add Book"## Example Scenario



#### Viewing Books1. Alice adds "The Great Gatsby" to her reading list

- **Challenge View**: See all books in a challenge2. Bob and Charlie can vote on whether they approve

- **User Profile**: View a specific user's books across all challenges3. If Bob votes 👎 (disapprove) and Charlie also votes 👎 (disapprove):

- **Book Details**: Click any book title to see:   - 2 out of 2 other users disapproved (100%)

  - Complete book information   - The book is marked as "Disapproved by Majority"

  - Who added it4. The book still shows in Alice's list but with a warning badge

  - Completion status5. Alice's statistics show: 1 total book, 0 approved, 1 disapproved

  - All veto records

  - Veto count and threshold status## Troubleshooting



#### Managing Your Books**Can't vote on a book:**

On your own books, you can:- Make sure you're not trying to vote on your own book

- **Edit**: Update any book details or add completion date- Check that you're logged in

- **Delete**: Remove a book from your reading list

- Books are always within a specific challenge**Don't see voting buttons:**

- You must be logged in to vote

### 4. Veto System- The book owner cannot vote on their own books



#### How Vetoing Works**Changes not showing:**

- Any participant can veto any book (except their own)- Refresh the page after adding/editing/deleting

- Each veto requires a detailed reason (10-500 characters)- Make sure the form submitted successfully (check for error messages)

- Vetos are public and visible to all

- Books with vetos ≥ threshold don't count for leaderboard## Administrator Features



#### Vetoing a BookIf you're logged in as an administrator (username: `admin`, password: `password`), you'll see a "👑 Admin" button in the navigation bar.

1. Open a book's detail page (not your own)

2. Scroll to "Veto this book" section### Accessing the Admin Panel

3. Enter a detailed reason explaining why (10-500 characters)

4. Click "🚫 Submit Veto"1. Log in with an admin account

5. Your veto appears in the public veto record2. Click the "👑 Admin" button in the top navigation

3. You'll be taken to the User Administration page

#### Removing Your Veto

1. Find your veto on the book's page### Managing Users

2. Click "Remove Veto"

3. Your veto is removed from the record**View All Users:**

- See a complete table of all users

#### Veto Guidelines- View user ID, username, email, admin status, book count, and join date

- Be constructive and specific- Filter between administrators and regular users

- Explain why the book doesn't fit the challenge

- Minimum 10 characters (to encourage detail)**Add New User:**

- Maximum 500 characters (to stay focused)1. Click "➕ Add New User"

2. Fill in the required information:

### 5. Leaderboards   - Username (must be unique)

   - Email address

#### Viewing Leaderboard   - Password (minimum 6 characters)

1. Open any challenge   - Password confirmation

2. Click "📊 View Leaderboard"   - Admin privileges checkbox (optional)

3. See rankings with:3. Click "Create User"

   - Participant names

   - Total completed books**Delete User:**

   - Valid books (completed minus vetoed books exceeding threshold)- Click the "Delete" button next to any user (except yourself)

   - Rank (based on valid books count)- Confirm the deletion

- **Warning**: Deleting a user will also delete all their books and votes

#### How Rankings Work

- Books must be **completed** (have a completion date)**User Statistics:**

- Books must **not exceed veto threshold** to count- Total number of users

- Rankings sorted by valid books count (highest first)- Number of administrators

- Ties broken alphabetically by username- Number of regular users



#### Winners### Admin Security

- Announced when challenge is complete (past due date)

- Top 3 participants get medals: 🥇🥈🥉- Only users with admin privileges can access the admin panel

- Based on final valid book count- Non-admin users who try to access admin URLs will be redirected

- Admins cannot delete themselves

### 6. User Profiles- At least one admin account should always exist



Each user's profile shows:## Database Reset

- Username and email

- Admin badge (if applicable)To start fresh with the sample data:

- Statistics:```bash

  - Total booksbin/rails db:reset

  - Completed booksbin/rails db:seed

  - In-progress books```

  - Challenges created

  - Challenges participatingThis will clear all data and reload the sample users (including the admin account) with their books and votes.

- List of challenges they're in
- All their books across challenges

### 7. Navigation

Main navigation includes:
- **Challenges**: Browse and manage challenges
- **Users**: View all participants
- **My Profile**: Your profile and stats (when logged in)
- **👑 Admin**: Admin panel (administrators only)
- **Logout**: Sign out

## Administrator Features

### Accessing the Admin Panel

1. Log in with an admin account
2. Click "👑 Admin" in the navigation
3. You'll see the User Administration page at `/admin/users`

### Managing Users

**View All Users:**
- See complete list with usernames, emails, admin status
- View statistics: total users, admin count, regular users

**Add New User:**
1. Click "➕ Add New User"
2. Enter email address (required)
3. Username (optional - auto-generated from email if not provided)
4. Check "Admin" box if creating an administrator
5. Click "Create User"
6. User must activate account at `/signup`

**Delete User:**
- Click "Delete" next to any user (except yourself)
- Confirm the deletion
- **Warning**: Deletes all their books, votes, challenges, and participations

### Admin Security

- Only users with `admin: true` can access admin panel
- Non-admin users redirected to home
- Admins cannot delete themselves
- Site administrator created one-time only

## Tips & Best Practices

1. **Password Security**: Use strong passwords with all required characters
2. **Veto Thoughtfully**: Provide constructive reasons for vetos
3. **Set Completion Dates**: Mark books complete when you finish them
4. **Join Multiple Challenges**: Participate in various reading themes
5. **Create Themed Challenges**: Specific genres, time periods, or goals
6. **Set Reasonable Thresholds**: Consider group size when setting veto threshold
7. **Check Leaderboards**: Track progress throughout the challenge
8. **Invite Participants**: Use the invite feature to build your challenge community

## Example Scenario

### Complete Challenge Flow

1. **Admin creates user:**
   - Admin adds `alice@example.com`
   
2. **Alice activates account:**
   - Visits `/signup`
   - Enters email and creates password `AliceReads2025!`
   
3. **Alice creates challenge:**
   - Name: "Summer Reading 2025"
   - Due date: September 1, 2025
   - Veto threshold: 2
   
4. **Alice invites users:**
   - Invites Bob and Carol
   - Both can now add books
   
5. **Users add books:**
   - Alice: "The Great Gatsby" (completed)
   - Bob: "1984" (completed)
   - Carol: "Pride and Prejudice" (in progress)
   
6. **Vetoing occurs:**
   - Bob vetos "The Great Gatsby": "Not summer-appropriate; focuses on tragedy"
   - Carol vetos "The Great Gatsby": "Too depressing for summer reading"
   - The book now has 2 vetos = threshold
   
7. **Leaderboard updates:**
   - Alice: 1 completed, 0 valid (vetoed book doesn't count)
   - Bob: 1 completed, 1 valid
   - Carol: 1 in progress, 0 valid
   - **Current leader: Bob**
   
8. **Challenge completes:**
   - September 1 arrives
   - Final standings determined
   - Bob wins with 1 valid completed book 🥇

## Troubleshooting

**Can't access admin signup:**
- This page only works once
- If admin exists, use `/login` instead

**Can't activate account:**
- Admin must create your account first
- Use exact email provided by admin
- Password must meet all requirements

**Can't add book:**
- Must be participating in the challenge
- Join challenge first, then add books

**Can't veto a book:**
- Can't veto your own books
- Must be participant in the challenge

**Book not counting on leaderboard:**
- Check if it has completion date
- Verify veto count vs threshold
- Red badge shows "Exceeds Veto Threshold"

**Can't edit challenge:**
- Only creator can edit/delete
- Other participants can only leave

## Keyboard Shortcuts & Quick Actions

- Click challenge name to view details
- Click user name to view profile
- Click book title for full details
- Use breadcrumbs to navigate back

## Data Management

### Resetting Database (Development Only)

**⚠️ WARNING: This deletes ALL data**

```bash
bin/rails db:reset
```

This will:
- Drop the database
- Recreate the database
- Run all migrations
- Clear all users, challenges, books, and vetos

After reset, you'll need to create the site administrator again.

## Support & Documentation

- **README.md**: Main project documentation
- **QUICK_START.md**: Quick reference guide
- **IMPLEMENTATION_COMPLETE.md**: Technical documentation
- **USAGE.md**: This file - comprehensive user guide
