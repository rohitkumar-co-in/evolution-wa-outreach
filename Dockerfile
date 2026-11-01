FROM node:22-alpine
ENV NODE_ENV=production
WORKDIR /app
COPY package*.json ./
RUN apk add --no-cache python3 make g++ && npm install --omit=dev && apk del python3 make g++
COPY . .
RUN mkdir -p /data
EXPOSE 3000
CMD ["npm","start"]
