FROM node:18-alpine

WORKDIR /app

COPY package.json pnpm-lock.yaml ./

RUN npm install -g pnpm

COPY . .

WORKDIR /app/apps/web

RUN pnpm install

EXPOSE 3000

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD curl -f https://aerobytes.nl || exit 1

CMD ["pnpm", "dev", "-H", "0.0.0.0"]