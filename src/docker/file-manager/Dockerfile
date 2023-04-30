FROM node:18.16.0

EXPOSE 8080

ENV NODE_ENV=production

WORKDIR /app
COPY app/. .

RUN npm install --production
RUN npm install --no-cache-dir -r requirements.txt

CMD ["node", "main.js"]