# Use the official Node.js 18 image as the base image
FROM node:18-alpine

# Install pnpm globally
RUN npm install -g pnpm

# Create and change to the app directory
WORKDIR /app

# Copy the pnpm workspace configuration and lockfile
COPY pnpm-workspace.yaml ./
COPY .npmrc ./
COPY pnpm-lock.yaml ./

# Copy the package.json files
COPY package.json ./
COPY apps/web/package.json apps/web/
COPY packages/*/package.json packages/*/

# Install dependencies recursively for all workspace packages
RUN pnpm install --recursive

# Copy the rest of the application code
COPY . .

# Build the Next.js application
RUN pnpm --filter web build

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the app
CMD ["pnpm", "--filter", "web", "start"]