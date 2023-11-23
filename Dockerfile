# Start from a Node.js version
FROM node:14 AS build

# Set the working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy local code to the container image
COPY . .

# Build the application
RUN npm run build

FROM ngnix:1.17.1-alpine

EXPOSE 80

WORKDIR /usr/share/nginx/html

COPY --from=build /usr/src/app/dist/front .
