# Quick Production Setup with Caddy

## Minimal Setup (5 minutes)

### 1. Set Environment Variables

```bash
cd /Users/mlbright/Source/readingchallenge

# Generate secret
export SECRET_KEY_BASE=$(bundle exec rails secret)
export RAILS_ENV=production
```

### 2. Prepare Database

```bash
bundle exec rails db:migrate RAILS_ENV=production
bundle exec rails assets:precompile RAILS_ENV=production
```

### 3. Configure Caddy

Edit `/etc/caddy/Caddyfile`:

```caddy
readingchallenge.yourdomain.com {
    reverse_proxy localhost:3000
}
```

Reload Caddy:
```bash
sudo caddy reload
```

### 4. Start Application

```bash
bundle exec rails server -e production -p 3000 -b 127.0.0.1
```

### 5. Visit Your Site

```
https://readingchallenge.yourdomain.com
```

## Key Command Differences

### Development:
```bash
bin/rails server
# Runs on http://localhost:3000
```

### Production:
```bash
export RAILS_ENV=production
export SECRET_KEY_BASE=$(bundle exec rails secret)
bundle exec rails server -p 3000 -b 127.0.0.1
# Caddy proxies https://yourdomain.com → http://localhost:3000
```

## What Changes in Production:

1. **Environment**: `RAILS_ENV=production` instead of `development`
2. **Secret Key**: Must set `SECRET_KEY_BASE` environment variable
3. **Port Binding**: Bind to `127.0.0.1` (localhost only), not public
4. **SSL**: Caddy handles SSL/TLS automatically
5. **Assets**: Must precompile: `rails assets:precompile`
6. **No Auto-reload**: Code changes require restart
7. **Process Management**: Use systemd, Docker, or similar
8. **Logging**: Goes to `log/production.log`

## For Long-Term Production

See [PRODUCTION_DEPLOYMENT.md](PRODUCTION_DEPLOYMENT.md) for:
- systemd service setup
- Docker deployment
- Database backups
- Monitoring
- Security hardening
- Performance tuning
