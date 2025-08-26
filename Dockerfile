FROM node:22

WORKDIR /usr/app

#COPY package.json .
COPY . .

RUN npm install

RUN npm run test

RUN npm run build

CMD ["node", "dist/main.js"]