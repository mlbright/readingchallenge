# Development vs Production Deployment Summary

## Command Comparison

| Task | Development | Production |
|------|-------------|------------|
| **Start server** | `bin/rails server` | `RAILS_ENV=production SECRET_KEY_BASE=xxx bundle exec rails server -p 3000 -b 127.0.0.1` |
| **Database setup** | `bin/rails db:setup` | `RAILS_ENV=production bundle exec rails db:migrate` |
| **Assets** | Auto-compiled on request | `RAILS_ENV=production bundle exec rails assets:precompile` |
| **Console** | `bin/rails console` | `RAILS_ENV=production bundle exec rails console` |
| **Logs** | `tail -f log/development.log` | `tail -f log/production.log` |

## Environment Variables

### Development (none required)
- `RAILS_ENV` defaults to `development`
- Secret key automatically generated
- No SSL required

### Production (required)
```bash
export RAILS_ENV=production
export SECRET_KEY_BASE=$(bundle exec rails secret)  # Required!
export PORT=3000                                     # Optional, defaults to 3000
export RAILS_LOG_LEVEL=info                         # Optional, defaults to info
```

## Caddy Reverse Proxy Setup

### Simple Caddyfile
```caddy
readingchallenge.example.com {
    reverse_proxy localhost:3000
}
```

### With Advanced Options
```caddy
readingchallenge.example.com {
    reverse_proxy localhost:3000 {
        header_up X-Real-IP {remote_host}
        header_up X-Forwarded-For {remote_host}
        header_up X-Forwarded-Proto {scheme}
    }
    
    encode gzip
    
    log {
        output file /var/log/caddy/readingchallenge.log
    }
}
```

## Network Access

### Development
- App listens on `0.0.0.0:3000` (all interfaces)
- Direct access: `http://localhost:3000`
- Accessible from local network

### Production with Caddy
- App listens on `127.0.0.1:3000` (localhost only)
- No direct access from outside
- Caddy listens on `0.0.0.0:80` and `0.0.0.0:443`
- Public access: `https://readingchallenge.example.com`
- Caddy proxies to `http://127.0.0.1:3000`

```
Internet → Caddy (443) → Rails App (3000)
          ↓
       SSL/TLS
     Let's Encrypt
```

## Database

### Development
- Location: `storage/development.sqlite3`
- Automatically created
- Can be reset/recreated easily

### Production
- Location: `storage/production.sqlite3`
- Must be backed up regularly
- Migrations must be run explicitly
- Consider file permissions: `chmod 660 storage/production.sqlite3`

## Assets (CSS, JS, Images)

### Development
- Compiled on-the-fly
- Changes reflect immediately
- Slower but convenient

### Production
- Must precompile before starting: `rails assets:precompile`
- Served from `public/assets/`
- Cached for performance
- Recompile after code changes

## Logging

### Development
```bash
# Logs to console and log/development.log
tail -f log/development.log
```

### Production
```bash
# Logs to log/production.log (less verbose)
tail -f log/production.log

# Caddy logs
tail -f /var/log/caddy/readingchallenge.log
```

## Process Management

### Development
```bash
# Start manually
bin/rails server

# Stop with Ctrl+C
```

### Production
```bash
# Option 1: systemd service
sudo systemctl start readingchallenge
sudo systemctl stop readingchallenge
sudo systemctl restart readingchallenge

# Option 2: Docker
docker start readingchallenge
docker stop readingchallenge

# Option 3: Background process
bundle exec rails server -e production -d  # daemon mode
```

## Security Considerations

### Development
- Debug info exposed
- Detailed error pages
- No SSL required
- Permissive CORS

### Production
- Error details hidden
- Generic error pages
- SSL/TLS required (`config.force_ssl = true`)
- `SECRET_KEY_BASE` must be secure
- Host authorization enabled
- Should run as non-root user

## Performance

### Development
- Code reloading enabled
- Caching disabled
- Single process
- Verbose logging

### Production
- No code reloading
- Full caching enabled
- Multiple workers possible
- Minimal logging
- Asset fingerprinting

## Full Startup Comparison

### Development
```bash
cd /Users/mlbright/Source/readingchallenge
bin/rails server
# Visit http://localhost:3000
```

### Production
```bash
cd /Users/mlbright/Source/readingchallenge

# Set environment
export RAILS_ENV=production
export SECRET_KEY_BASE=$(bundle exec rails secret)

# Prepare
bundle install --without development test
bundle exec rails db:migrate
bundle exec rails assets:precompile

# Start (choose one method)

# Method 1: Direct
bundle exec rails server -p 3000 -b 127.0.0.1

# Method 2: With systemd (recommended)
sudo systemctl start readingchallenge

# Method 3: With Docker
docker run -d -p 3000:3000 \
  -e RAILS_MASTER_KEY=$(cat config/master.key) \
  readingchallenge

# Visit https://readingchallenge.example.com (via Caddy)
```

## Restart After Changes

### Development
- Automatic (code reloading)
- Or: Ctrl+C and restart

### Production
```bash
# With systemd
sudo systemctl restart readingchallenge

# With Docker
docker restart readingchallenge

# Without process manager
touch tmp/restart.txt  # if using Passenger
# or kill and restart manually
```

## Deployment Checklist

When deploying to production behind Caddy:

- [ ] Set `RAILS_ENV=production`
- [ ] Set `SECRET_KEY_BASE` (generate with `rails secret`)
- [ ] Run database migrations
- [ ] Precompile assets
- [ ] Configure Caddy with your domain
- [ ] Bind Rails to `127.0.0.1:3000` only
- [ ] Set up process management (systemd recommended)
- [ ] Configure log rotation
- [ ] Set up database backups
- [ ] Ensure `storage/` directory has correct permissions
- [ ] Verify SSL certificate (Caddy handles automatically)
- [ ] Update `config.hosts` in `config/environments/production.rb`

## Quick Reference: Port and Binding

```bash
# Development: accessible from anywhere
bundle exec rails server
# Binds to: 0.0.0.0:3000
# Access: http://localhost:3000 or http://your-ip:3000

# Production: localhost only
bundle exec rails server -e production -b 127.0.0.1 -p 3000
# Binds to: 127.0.0.1:3000
# Access: Only via Caddy proxy at https://yourdomain.com
```

## Troubleshooting

### "Secret key base is not set"
```bash
export SECRET_KEY_BASE=$(bundle exec rails secret)
```

### "Cannot connect to app"
Check if app is running and bound correctly:
```bash
curl http://localhost:3000/up
```

### "Assets not loading"
```bash
RAILS_ENV=production bundle exec rails assets:clobber
RAILS_ENV=production bundle exec rails assets:precompile
```

### "Caddy can't connect to app"
```bash
# Verify app is listening
ss -tlnp | grep 3000

# Check Caddy config
sudo caddy validate --config /etc/caddy/Caddyfile
```
