#FROM node:18-alpine
#
#WORKDIR /app
#
#COPY package.json pnpm-lock.yaml ./
#
## Install pnpm and dependencies
#RUN npm install -g pnpm && pnpm install --frozen-lockfile
#
## Install additional packages
#RUN apk add --no-cache curl wget
#
#COPY . .
#
## Ensure dependencies are installed in all packages
#WORKDIR /app/packages/render
#RUN pnpm install && pnpm add @tiptap/core
#
#WORKDIR /app/apps/web
#RUN pnpm install
#
## Expose the correct port
#EXPOSE 3000
#
## Set environment variable to bind to 0.0.0.0
#ENV HOST=0.0.0.0
#ENV PORT=3000
#
## Start the application
#CMD ["pnpm", "dev"]
# Use the official Node.js 16 image as the base image
FROM node:16-alpine

# Create and change to the app directory
WORKDIR /app

# Copy the package.json and package-lock.json files
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Next.js application
RUN npm run build

# Expose the port the app runs on
EXPOSE 3000

# Define the command to run the app
CMD ["npm", "start"]