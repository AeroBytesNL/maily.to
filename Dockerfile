FROM node:18-alpine

WORKDIR /app

COPY package.json pnpm-lock.yaml ./

RUN npm install -g pnpm

COPY . .

WORKDIR /app/apps/web

RUN pnpm install

EXPOSE 3000

CMD ["pnpm", "dev", "--host"]