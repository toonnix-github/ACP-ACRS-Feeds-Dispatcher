# --- Build stage ---
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# --- Test stage ---
FROM build AS test
RUN npm ci
COPY . .
RUN npm test

# --- Runtime stage ---
FROM node:20-alpine AS runtime
WORKDIR /app
COPY --from=build /app/node_modules ./node_modules
COPY . .
EXPOSE 8080
USER node
CMD ["node", "src/index.js"]
