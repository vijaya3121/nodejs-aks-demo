# Step 1: Use Node.js official image
FROM node:18

# Step 2: Set working directory inside the container
WORKDIR /app

# Step 3: Copy package files first (for caching)
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy all source code
COPY . .

# Step 6: Expose port 3000
EXPOSE 3000

# Step 7: Command to run the app
CMD ["npm", "start"]
