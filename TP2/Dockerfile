FROM node:lts

ENV API_KEY=""
ENV PORT=8081

EXPOSE 8081

WORKDIR /home

COPY package*.json ./

RUN npm install

COPY index.js .

CMD ["npm", "start"]