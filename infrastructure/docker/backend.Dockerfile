FROM node:18-alpine
WORKDIR /app
COPY services/package.json services/package-lock.json ./
RUN npm install
COPY services .  
EXPOSE 5000
CMD ["node", "app.js"]
