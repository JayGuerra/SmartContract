# Use the official Node.js 14 image as a parent image
FROM node:14

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json for npm install
# This is beneficial for caching and faster builds
# Only copy these files if you have them. If not, this step can be skipped
# COPY package*.json ./

# Install dependencies
# If you have a package.json file, uncomment the COPY command above and this line
# RUN npm install

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

# Make port 3000 available to the outside from the container
EXPOSE 3000

# Run the app when the container launches
CMD ["npx", "create-react-app", "mortgage-dapp"]
