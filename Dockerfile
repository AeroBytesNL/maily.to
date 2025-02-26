FROM node:18-alpine

WORKDIR /app

COPY package.json pnpm-lock.yaml ./

RUN npm install -g pnpm

RUN apk add --no-cache curl wget

COPY . .

WORKDIR /app/packages/render

RUN pnpm add @tiptap/core

WORKDIR /app/apps/web

# Delete old sh*t
RUN rm -rf /app/apps/web/node_modules
RUN rm -rf /app/node_modules

RUN pnpm add @maily-to/core

RUN pnpm install

EXPOSE 3000
ENV HOST=0.0.0.0
ENV PORT=3000

CMD ["pnpm", "dev"]
