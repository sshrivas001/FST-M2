# Specify Base Image
FROM docker.io/node:18-alpine

# Work Directory
WORKDIR /usr/app

#Copying dev files into the container
COPY ./package.json ./

# Install Dependencies
RUN npm install

COPY . .

# Startup Command
CMD ["npm", "run","serve"]