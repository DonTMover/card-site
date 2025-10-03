FROM node:18-alpine AS nodebuilder
WORKDIR /src
COPY package.json package-lock.json ./
RUN npm ci --no-audit --no-fund --silent || true

FROM klakegg/hugo:0.150.1-ext AS builder
WORKDIR /src

# copy node_modules from node stage so Hugo's PostCSS/Tailwind can run via Hugo Pipes
COPY --from=nodebuilder /src/node_modules ./node_modules

COPY . .
RUN hugo --minify

FROM nginx:alpine
RUN rm -f /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=builder /src/public /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]