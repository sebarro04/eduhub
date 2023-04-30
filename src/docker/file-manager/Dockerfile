FROM node:18.16.0

EXPOSE 3000

ENV NODE_ENV=production

WORKDIR /app
COPY app/. .

RUN npm install --production

CMD ["node", "app.js"]