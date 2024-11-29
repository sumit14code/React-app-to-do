# Step 1: Use an official Node.js image to build the app
FROM node:16 AS build

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy the package.json and package-lock.json (if exists)
COPY package*.json ./

# Step 4: Install the dependencies (in a clean, minimal environment)
RUN npm install

# Step 5: Copy the rest of the application code
COPY . .

# Step 6: Build the React app for production
RUN npm run build

# Step 7: Use Nginx to serve the static files
FROM nginx:alpine

# Step 8: Copy the build directory from the previous stage into the Nginx server
COPY --from=build /app/build /usr/share/nginx/html

# Step 9: Expose port 80 to the outside world
EXPOSE 80

# Step 10: Start Nginx when the container runs
CMD ["nginx", "-g", "daemon off;"]
