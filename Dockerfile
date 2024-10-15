# Stage 1: Build Angular app
FROM node:latest AS web
WORKDIR /node-app

# Copy all files to the container
COPY . /node-app

# Install NVM, Node.js, and Angular CLI using bash
RUN apt-get update && apt-get install -y bash && \
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash && \
    bash -c "source ~/.bashrc && nvm install node" && \
    npm install -g @angular/cli

# Install dependencies and build the Angular app
RUN npm install && \
    ng build

# Stage 2: Nginx setup
FROM nginx:latest
RUN rm -rf /usr/share/nginx/html/*

# Copy the built Angular app to the Nginx html folder
COPY --from=web /node-app/dist/angular-app/browser/ /usr/share/nginx/html
