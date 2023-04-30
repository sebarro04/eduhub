FROM node:18.16.0

EXPOSE 8080

ENV NODE_ENV=production

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY app/. .

RUN npm run build

CMD ["node", "app.js"]