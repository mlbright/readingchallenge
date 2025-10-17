# Reading Challenge

A Ruby on Rails web application for tracking a yearly reading challenge among multiple users.

## Features

- **User Authentication**: Sign up and log in with username/password
- **Book Management**: Users can add, edit, and delete their own books
- **Book Details**: Each book includes:
  - Title
  - Author
  - Number of pages
  - Description
  - URL to Amazon or other bookstores
- **Community Voting**: Users can vote to approve or disapprove other users' books
- **Majority Voting System**: If a majority of users disapprove a book, it's marked as "Disapproved by Majority"
- **User Profiles**: View any user's reading list with approval statistics
- **Book Tallies**: Track total books, approved books, and disapproved books per user

## Getting Started

### Prerequisites

- Ruby 3.4.2 or higher
- Rails 8.0.3 or higher
- SQLite3

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   bin/rails db:migrate
   bin/rails db:seed
   ```

4. Start the server:
   ```bash
   bin/rails server
   ```

5. Visit http://localhost:3000

### Sample Accounts

The seed file creates three sample accounts you can use to test the application:

- Username: `alice`, Password: `password`
- Username: `bob`, Password: `password`
- Username: `charlie`, Password: `password`

## Usage

1. **Sign Up/Login**: Create a new account or login with existing credentials
2. **View Users**: See all participants in the reading challenge
3. **Add Books**: Add books you've read with details and links
4. **Vote on Books**: Approve or disapprove books added by other users
5. **Track Progress**: View your reading list and see which books have been approved or disapproved by the community

## How Voting Works

- Users cannot vote on their own books
- Each user can cast one vote (approve or disapprove) per book
- If more than half of the other users disapprove a book, it's marked as "Disapproved by Majority"
- This disapproved status is displayed prominently on user profiles and book listings
- Users can change or remove their votes at any time

## Models

- **User**: Authentication and profile information
- **Book**: Reading list entries with details
- **Vote**: Community approval/disapproval votes

## Technology Stack

- Ruby on Rails 8.0.3
- SQLite3 database
- Turbo & Stimulus (Hotwire)
- Simple authentication with `has_secure_password`

## License

This project is open source and available under the MIT License.
