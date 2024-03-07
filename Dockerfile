FROM node:20-alpine as builder-with-pnpm

ENV NODE_ENV build
RUN npm install -g pnpm

FROM builder-with-pnpm as builder

WORKDIR /home/node

# pnpm fetch does require only lockfile
COPY pnpm-lock.yaml ./

RUN pnpm fetch

COPY --chown=node:node . .
RUN pnpm install -r --offline
ENV NODE_ENV production
RUN pnpm run build \
    && pnpm prune --production

# ---

FROM node:20-alpine

RUN echo "Asia/shanghai" > /etc/timezone

USER node
ENV PORT 3000
ENV NODE_ENV production
WORKDIR /home/app

COPY --from=builder --chown=node:node /home/node/package*.json ./
COPY --from=builder --chown=node:node /home/node/node_modules/ ./node_modules/
COPY --from=builder --chown=node:node /home/node/.svelte-kit/ ./.svelte-kit/
COPY --from=builder --chown=node:node /home/node/build/ ./build/

HEALTHCHECK --interval=5s --timeout=3s \
    CMD wget --spider -q http://127.0.0.1:3000 || exit 1
EXPOSE 3000

CMD ["node","build/index.js"]
