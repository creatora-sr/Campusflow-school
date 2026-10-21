# Multi-stage Dockerfile for CampusFlow
FROM node:24-alpine AS builder

# Build frontend
WORKDIR /app/client
COPY client/package*.json ./
RUN npm ci
COPY client/ ./
RUN npm run build

# Build backend
WORKDIR /app/server
COPY server/package*.json ./
RUN npm ci --production

# Production image
FROM node:24-alpine
WORKDIR /app

# Copy server files
COPY server/ /app/server/
RUN cd /app/server && npm ci --production

# Copy built frontend
COPY --from=builder /app/client/dist /app/client/dist

# Copy uploads directory
RUN mkdir -p /app/server/uploads/assignments

# Environment
ENV NODE_ENV=production
ENV PORT=5000

# Expose ports
EXPOSE 5000

# Start server
WORKDIR /app/server
CMD ["node", "server.js"]