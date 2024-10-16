# Specify Base Image
FROM docker.io/node:18-alpine

# Work Directory
WORKDIR /usr/app

# Copying the dev files into the container
Copy ./ ./

# Install Dependencies
RUN npm install

# Startup Command
CMD ["npm", "start"]