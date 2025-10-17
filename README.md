# Reading Challenge Platform

A Ruby on Rails application for managing multi-tenant reading challenges with community moderation through a veto system.

## Features

### Multi-Challenge System

- Users can create up to 100 reading challenges
- Each challenge has its own participants, books, and leaderboard
- Challenges have configurable veto thresholds and due dates
- Real-time leaderboards track progress throughout the challenge
- Winners determined when challenges complete
- Challenge creators can invite users to participate

### Veto System

- Community members can veto books with detailed reasons
- Each challenge sets its own veto threshold
- Books exceeding the threshold don't count toward leaderboard
- Public veto records promote transparency
- Minimum 10 characters, maximum 500 characters per veto reason
- Users cannot veto their own books

### Site Administration

- One-time admin setup: First person to visit creates the site administrator account
- Admins can create user accounts via email
- Users activate accounts by setting their own strong password
- Full user management interface

### Security Features

- Strong password requirements (12+ chars, uppercase, lowercase, digit, special char)
- Unique email and username constraints
- Database-level duplicate prevention
- Secure password hashing with bcrypt

### Book Tracking

- Books are challenge-specific
- Each user maintains their own reading list per challenge
- Track completion dates, descriptions, and external links
- Visual badges for completed vs in-progress books
- Books can be vetoed by other participants

## Getting Started

### Prerequisites

- Ruby 3.4.2 or higher
- Rails 8.0.3 or higher
- SQLite3

### Installation

1. Clone the repository
2. Install dependencies: `bundle install`
3. Set up the database: `bin/rails db:migrate`
4. Start the server: `bin/rails server`
5. Visit <http://localhost:3000>

## Documentation

- **QUICK_START.md**: Step-by-step getting started guide
- **USAGE.md**: Comprehensive user guide
- **IMPLEMENTATION_COMPLETE.md**: Complete technical documentation

## License

MIT License. See LICENSE file for details.
