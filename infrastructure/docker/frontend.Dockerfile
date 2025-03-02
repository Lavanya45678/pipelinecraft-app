# Build Stage
FROM node:18-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .  
RUN npm run build  # Generates /dist or /build

# Production Stage
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html  # Ensure correct path
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
