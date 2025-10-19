# Production Deployment with Caddy

This guide covers deploying the Reading Challenge application in production behind Caddy as a reverse proxy.

## Prerequisites

- Ruby 3.4.2 installed
- SQLite3
- Caddy installed and running
- A domain name (e.g., `readingchallenge.example.com`)

## Key Differences: Development vs Production

### Environment Variables

**Development:**
```bash
RAILS_ENV=development
```

**Production:**
```bash
RAILS_ENV=production
SECRET_KEY_BASE=<generated_secret>
RAILS_MASTER_KEY=<from config/master.key>
RAILS_LOG_LEVEL=info
```

### Port Configuration

**Development:**
- Runs on port 3000 by default
- Accessible at `http://localhost:3000`

**Production:**
- Should run on a local port (e.g., 3000 or 8080)
- Caddy listens on 80/443 and proxies to your app
- Not directly accessible from outside

### SSL/TLS

**Development:**
- No SSL (http only)

**Production:**
- Caddy handles SSL/TLS automatically with Let's Encrypt
- App configured with `config.force_ssl = true`
- `config.assume_ssl = true` (trusts Caddy's SSL termination)

## Step-by-Step Production Setup

### 1. Prepare the Application

```bash
# Navigate to your app directory
cd /Users/mlbright/Source/readingchallenge

# Install production dependencies
bundle install --without development test

# Generate a secret key base
bundle exec rails secret
# Copy the output - you'll need this for SECRET_KEY_BASE
```

### 2. Set Environment Variables

Create a `.env.production` file (or export these in your shell):

```bash
# Required
RAILS_ENV=production
SECRET_KEY_BASE=your_generated_secret_from_step_1

# Optional - customize as needed
PORT=3000
RAILS_LOG_LEVEL=info
RAILS_MAX_THREADS=5
WEB_CONCURRENCY=2

# If you don't have config/master.key, you may need:
# RAILS_MASTER_KEY=<content of config/master.key>
```

**Important:** Never commit `.env.production` to version control!

Add to `.gitignore`:
```bash
echo ".env.production" >> .gitignore
```

### 3. Prepare the Database

```bash
# Load environment
export $(cat .env.production | xargs)

# Create and migrate database
bundle exec rails db:create RAILS_ENV=production
bundle exec rails db:migrate RAILS_ENV=production

# Optional: Load seed data
bundle exec rails db:seed RAILS_ENV=production
```

### 4. Precompile Assets

```bash
bundle exec rails assets:precompile RAILS_ENV=production
```

### 5. Configure Caddy

Create or edit your Caddyfile (typically at `/etc/caddy/Caddyfile`):

```caddy
readingchallenge.example.com {
    # Reverse proxy to Rails app
    reverse_proxy localhost:3000

    # Enable compression
    encode gzip

    # Security headers
    header {
        # Enable HSTS
        Strict-Transport-Security "max-age=31536000; includeSubDomains; preload"
        
        # Prevent clickjacking
        X-Frame-Options "SAMEORIGIN"
        
        # Prevent MIME sniffing
        X-Content-Type-Options "nosniff"
        
        # Enable XSS protection
        X-XSS-Protection "1; mode=block"
        
        # Control referrer information
        Referrer-Policy "strict-origin-when-cross-origin"
    }

    # Logging
    log {
        output file /var/log/caddy/readingchallenge.log
        format json
    }
}
```

**For development/testing with self-signed cert:**
```caddy
localhost:443 {
    reverse_proxy localhost:3000
    tls internal
}
```

Reload Caddy:
```bash
sudo caddy reload --config /etc/caddy/Caddyfile
```

### 6. Update Production Config

Edit `config/environments/production.rb`:

```ruby
# Set your actual domain
config.action_mailer.default_url_options = { 
  host: "readingchallenge.example.com",
  protocol: 'https'
}

# Allow your domain
config.hosts = [
  "readingchallenge.example.com",
  /.*\.readingchallenge\.example\.com/
]
```

### 7. Start the Application

#### Option A: Direct Ruby Command

```bash
# Load environment variables
export $(cat .env.production | xargs)

# Start Puma
bundle exec puma -C config/puma.rb -e production
```

#### Option B: Using Rails Command

```bash
export $(cat .env.production | xargs)
bundle exec rails server -e production -p 3000
```

#### Option C: With Thruster (HTTP/2 + Caching)

```bash
export $(cat .env.production | xargs)
bundle exec thrust bundle exec rails server -e production -p 3000
```

### 8. Process Management with systemd

Create `/etc/systemd/system/readingchallenge.service`:

```ini
[Unit]
Description=Reading Challenge Rails App
After=network.target

[Service]
Type=simple
User=deploy
WorkingDirectory=/home/deploy/readingchallenge
Environment=RAILS_ENV=production
Environment=PORT=3000
Environment=RAILS_LOG_LEVEL=info
Environment=SECRET_KEY_BASE=your_secret_key_here

# If using config/master.key:
# Environment=RAILS_MASTER_KEY=your_master_key_here

ExecStart=/home/deploy/.rbenv/shims/bundle exec puma -C config/puma.rb

# Restart policy
Restart=always
RestartSec=10

# Logging
StandardOutput=append:/var/log/readingchallenge/stdout.log
StandardError=append:/var/log/readingchallenge/stderr.log

[Install]
WantedBy=multi-user.target
```

Create log directory:
```bash
sudo mkdir -p /var/log/readingchallenge
sudo chown deploy:deploy /var/log/readingchallenge
```

Enable and start:
```bash
sudo systemctl daemon-reload
sudo systemctl enable readingchallenge
sudo systemctl start readingchallenge
sudo systemctl status readingchallenge
```

## Docker Deployment (Alternative)

### Build the Docker Image

```bash
docker build -t readingchallenge .
```

### Run with Docker

```bash
docker run -d \
  --name readingchallenge \
  -p 3000:80 \
  -e RAILS_MASTER_KEY=$(cat config/master.key) \
  -v $(pwd)/storage:/rails/storage \
  readingchallenge
```

### Caddy config for Docker:

```caddy
readingchallenge.example.com {
    reverse_proxy localhost:3000
}
```

### Docker Compose

Create `docker-compose.yml`:

```yaml
version: '3.8'

services:
  web:
    build: .
    ports:
      - "3000:80"
    environment:
      - RAILS_MASTER_KEY=${RAILS_MASTER_KEY}
    volumes:
      - ./storage:/rails/storage
      - ./log:/rails/log
    restart: unless-stopped
```

Run:
```bash
RAILS_MASTER_KEY=$(cat config/master.key) docker-compose up -d
```

## Monitoring and Maintenance

### View Logs

**Systemd:**
```bash
sudo journalctl -u readingchallenge -f
```

**Direct logs:**
```bash
tail -f log/production.log
```

**Caddy logs:**
```bash
tail -f /var/log/caddy/readingchallenge.log
```

### Restart Application

**Systemd:**
```bash
sudo systemctl restart readingchallenge
```

**Docker:**
```bash
docker restart readingchallenge
```

**Without systemd (creates tmp/restart.txt):**
```bash
bundle exec rails restart
```

### Database Backup

```bash
# Backup SQLite database
cp storage/production.sqlite3 "storage/backup-$(date +%Y%m%d-%H%M%S).sqlite3"

# Automated backup script
#!/bin/bash
BACKUP_DIR="/backups/readingchallenge"
DATE=$(date +%Y%m%d-%H%M%S)
mkdir -p $BACKUP_DIR
sqlite3 storage/production.sqlite3 ".backup $BACKUP_DIR/production-$DATE.sqlite3"
# Keep only last 30 days
find $BACKUP_DIR -name "*.sqlite3" -mtime +30 -delete
```

### Updates and Deployments

```bash
# Pull latest code
git pull origin main

# Install dependencies
bundle install --without development test

# Run migrations
bundle exec rails db:migrate RAILS_ENV=production

# Precompile assets
bundle exec rails assets:precompile RAILS_ENV=production

# Restart
sudo systemctl restart readingchallenge
```

## Security Checklist

- [ ] `SECRET_KEY_BASE` is set and secure
- [ ] `config/master.key` is kept secure and not in version control
- [ ] Database file has proper permissions (600 or 660)
- [ ] Caddy is handling SSL/TLS with valid certificates
- [ ] `config.force_ssl = true` is enabled
- [ ] Host authorization is configured
- [ ] Regular database backups are configured
- [ ] Log rotation is set up
- [ ] Firewall allows only necessary ports (80, 443)
- [ ] Application runs as non-root user

## Performance Tuning

### Puma Configuration

Edit `config/puma.rb`:

```ruby
# Increase workers for multi-core systems
workers ENV.fetch("WEB_CONCURRENCY", 2)

# Increase threads
threads_count = ENV.fetch("RAILS_MAX_THREADS", 5)
threads threads_count, threads_count

# Preload app for better memory usage with multiple workers
preload_app!

# On worker boot (if using workers)
on_worker_boot do
  ActiveRecord::Base.establish_connection
end
```

Set environment variables:
```bash
export WEB_CONCURRENCY=2
export RAILS_MAX_THREADS=5
```

### Database Connection Pool

Edit `config/database.yml`:

```yaml
production:
  primary:
    <<: *default
    database: storage/production.sqlite3
    pool: <%= ENV.fetch("RAILS_MAX_THREADS", 5) %>
```

## Troubleshooting

### Check if app is running:
```bash
curl http://localhost:3000/up
```

### Check Caddy status:
```bash
sudo systemctl status caddy
sudo caddy validate --config /etc/caddy/Caddyfile
```

### Common Issues:

**"Secret key base is not set"**
```bash
export SECRET_KEY_BASE=$(bundle exec rails secret)
```

**"Permission denied on database"**
```bash
chown -R deploy:deploy storage/
chmod 660 storage/production.sqlite3
```

**"Assets not loading"**
```bash
bundle exec rails assets:clobber RAILS_ENV=production
bundle exec rails assets:precompile RAILS_ENV=production
```

## Environment-Specific Commands

### Development
```bash
bin/rails server
# or
bin/dev
```

### Production
```bash
# With environment file
export $(cat .env.production | xargs)
bundle exec rails server -e production -p 3000

# Or with systemd
sudo systemctl start readingchallenge
```

## Summary

| Aspect | Development | Production |
|--------|-------------|------------|
| Environment | `RAILS_ENV=development` | `RAILS_ENV=production` |
| Port | 3000 (direct access) | 3000 (behind Caddy on 80/443) |
| SSL | No | Yes (via Caddy) |
| Assets | Live compilation | Precompiled |
| Logging | Debug/verbose | Info level |
| Database | `storage/development.sqlite3` | `storage/production.sqlite3` |
| Process Manager | None | systemd or Docker |
| Code reloading | Yes | No |
| Caching | Minimal | Enabled |
| Workers | 1 | Multiple (configured) |

## Quick Reference

Start production app:
```bash
export RAILS_ENV=production
export SECRET_KEY_BASE=$(bundle exec rails secret)
bundle exec puma -C config/puma.rb
```

View logs:
```bash
tail -f log/production.log
```

Database console:
```bash
bundle exec rails dbconsole -e production
```

Rails console:
```bash
bundle exec rails console -e production
```
