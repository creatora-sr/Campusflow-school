# Deployment Guide for CampusFlow

## Option 1: Docker (Recommended)

```bash
# Start everything with one command
docker-compose up -d

# Access at http://localhost:5000
```

## Option 2: Vercel (Frontend) + Render (Backend)

### Backend (Render)
1. Create a new Web Service on Render
2. Connect your GitHub repository
3. Set build command: `cd server && npm install`
4. Set start command: `cd server && node server.js`
5. Add environment variables from `server/.env.example`

### Frontend (Vercel)
1. Import project to Vercel
2. Set build command: `cd client && npm run build`
3. Set output directory: `client/dist`
4. Set `VITE_API_URL` to your Render backend URL

## Option 3: Railway (All-in-One)

1. Create new project on Railway
2. Add MongoDB plugin
3. Deploy from GitHub
4. Set environment variables

## Option 4: Manual VPS (Ubuntu/Debian)

```bash
# 1. Install Node.js
curl -fsSL https://deb.nodesource.com/setup_24.x | sudo -E bash -
sudo apt-get install -y nodejs

# 2. Install MongoDB
sudo apt-get install -y mongodb-org

# 3. Clone and build
git clone <your-repo>
cd campusflow
cd client && npm install && npm run build
cd ../server && npm install

# 4. Set up environment
cp .env.example .env
# Edit .env with production values

# 5. Start with PM2
npm install -g pm2
pm2 start server.js --name campusflow
pm2 save
pm2 startup
```

## Environment Variables Required

| Variable | Description | Example |
|----------|-------------|---------|
| `MONGODB_URI` | MongoDB connection string | `mongodb+srv://user:pass@cluster.mongodb.net/campusflow` |
| `JWT_SECRET` | Secret for JWT tokens (32+ chars) | `random-string-at-least-32-characters` |
| `ADMIN_EMAIL` | Admin email | `admin@campusflow.local` |
| `ADMIN_PASSWORD` | Admin password | `SecurePassword123!` |
| `ADMIN_NAME` | Admin name | `School Admin` |
| `CLIENT_ORIGIN` | Frontend URL for CORS | `https://your-domain.com` |
| `NODE_ENV` | Environment | `production` |

## Production Checklist

- [ ] Set up MongoDB Atlas or persistent MongoDB
- [ ] Configure cloud storage for uploads (S3, etc.)
- [ ] Set up SSL certificate
- [ ] Configure proper CORS origins
- [ ] Set strong JWT_SECRET (32+ chars)
- [ ] Rotate admin password
- [ ] Set up monitoring (PM2, Sentry, etc.)
- [ ] Configure backup for MongoDB
- [ ] Set up CDN for static assets