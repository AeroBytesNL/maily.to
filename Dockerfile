FROM node:18-alpine

WORKDIR /app

COPY package.json pnpm-lock.yaml ./

# Install pnpm and dependencies
RUN npm install -g pnpm && pnpm install --frozen-lockfile

# Install additional packages
RUN apk add --no-cache curl wget

COPY . .

# Ensure dependencies are installed in all packages
WORKDIR /app/packages/render
RUN pnpm install && pnpm add @tiptap/core

WORKDIR /app/apps/web
RUN pnpm install

# Expose the correct port
EXPOSE 3000

# Set environment variable to bind to 0.0.0.0
ENV HOST=0.0.0.0
ENV PORT=3000

# Start the application
CMD ["pnpm", "dev"]
