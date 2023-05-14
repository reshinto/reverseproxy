# FROM node
# WORKDIR /usr/src/app
# COPY package*.json ./
# RUN npm install --omit=dev

# COPY . .

# EXPOSE 5000
# CMD ["node", "index.js"]

# FROM node:lts-alpine

# WORKDIR /app

# RUN apk update && apk add --no-cache nmap && \
#     echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
#     echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
#     apk update && \
#     apk add --no-cache \
#       chromium \
#       harfbuzz \
#       "freetype>2.8" \
#       ttf-freefont \
#       nss

# ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true

# COPY . .

# RUN npm install --omit=dev

# EXPOSE 5000

# CMD ["node", "index.js"]

# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory to /app
WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm install

# Install puppeteer
RUN apt-get update \
    && apt-get install -yq libgconf-2-4 \
    && apt-get install -y wget gnupg \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && npm i puppeteer

# Copy the current directory contents into the container at /app
COPY . /app

# Make port 3000 available to the world outside this container
EXPOSE 5000

# Run the app when the container launches
CMD ["npm", "start"]