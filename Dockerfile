# Use an official Node.js runtime as a parent image
FROM node:14

# Set the working directory to /app
WORKDIR /app

# Install app dependencies
COPY package*.json ./
RUN npm install --omit=dev

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
CMD ["node", "index.js"]