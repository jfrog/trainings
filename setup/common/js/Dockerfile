FROM node:16.19.0

# Create app directory
WORKDIR /usr/src/app
COPY package*.json ./

RUN npm install
EXPOSE 3000

COPY server.js ./
COPY public public/
COPY views views/
COPY fake_tokens.txt /usr/src/
CMD [ "node", "server.js" ]

