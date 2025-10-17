# Reading Challenge - User Guide

## Quick Start

1. **Start the application:**
   ```bash
   bin/rails server
   ```

2. **Visit:** http://localhost:3000

3. **Login with a sample account:**
   - Username: `alice`, Password: `password`
   - Username: `bob`, Password: `password`  
   - Username: `charlie`, Password: `password`

## Features Overview

### 1. User Registration & Authentication
- Click "Sign Up" to create a new account
- Provide a username, email, and password
- Once registered, you'll be automatically logged in

### 2. Viewing Participants
- The home page shows all users participating in the reading challenge
- Each user card displays:
  - Username
  - Total books read
  - Number of approved books
  - Number of disapproved books (if any)
- Click "View Books" to see a user's complete reading list

### 3. Adding Books
- Click "Add Book" in the navigation or on your profile
- Fill in the book details:
  - **Title** (required): The book's title
  - **Author** (required): The book's author
  - **Pages** (required): Number of pages
  - **Description** (optional): A brief description of the book
  - **URL** (optional): Link to Amazon, Goodreads, or another bookstore

### 4. Viewing Books
- **All Books**: See every book added by all participants
- **User Profile**: View a specific user's reading list
- **Book Details**: Click on any book title to see full details including:
  - Complete book information
  - Purchase/info link (if provided)
  - All votes from other users
  - Approval status

### 5. Voting System
- You can vote on any book except your own
- Two voting options:
  - **👍 Approve**: You think the book is valid for the challenge
  - **👎 Disapprove**: You don't think the book should count

#### How Majority Voting Works:
- If **more than half** of other users disapprove a book, it's marked as "Disapproved by Majority"
- For example, with 3 total users:
  - Book owner: 1 user (cannot vote on their own book)
  - Other users: 2 users
  - If 2 users disapprove (more than half of 2), the book is disapproved

- Disapproved books:
  - Show a warning badge (⚠️)
  - Are highlighted in red in lists
  - Still count in the user's total but are separately tracked

### 6. Managing Your Books
On your own books, you can:
- **Edit**: Update any book details
- **Delete**: Remove a book from your reading list

### 7. User Statistics
Each user's profile shows:
- **Total Books**: All books added
- **Approved**: Books not disapproved by the majority
- **Disapproved by Majority**: Books that more than half of users disapproved

## Navigation

- **Reading Challenge** (logo): Go to home page (all users)
- **All Users**: View all participants
- **All Books**: Browse all books in the challenge
- **Add Book**: Add a new book to your list
- **My Profile**: View your own reading list
- **Logout**: Sign out of your account

## Tips

1. **Be honest with voting**: The goal is to maintain integrity in the reading challenge
2. **Add descriptions**: Help others understand why you liked a book
3. **Include URLs**: Make it easy for others to find and purchase books they're interested in
4. **Check the All Books page**: Discover what others are reading
5. **Vote on books**: Participate in the community by reviewing others' books

## Example Scenario

1. Alice adds "The Great Gatsby" to her reading list
2. Bob and Charlie can vote on whether they approve
3. If Bob votes 👎 (disapprove) and Charlie also votes 👎 (disapprove):
   - 2 out of 2 other users disapproved (100%)
   - The book is marked as "Disapproved by Majority"
4. The book still shows in Alice's list but with a warning badge
5. Alice's statistics show: 1 total book, 0 approved, 1 disapproved

## Troubleshooting

**Can't vote on a book:**
- Make sure you're not trying to vote on your own book
- Check that you're logged in

**Don't see voting buttons:**
- You must be logged in to vote
- The book owner cannot vote on their own books

**Changes not showing:**
- Refresh the page after adding/editing/deleting
- Make sure the form submitted successfully (check for error messages)

## Database Reset

To start fresh with the sample data:
```bash
bin/rails db:reset
bin/rails db:seed
```

This will clear all data and reload the three sample users with their books and votes.
