# Use Node.js image the base
FROM node:18

# Set the working directory for the container
WORKDIR /usr/src/app

# Copy js file into container
COPY server.js .

# Expose port 8080
EXPOSE 8080

# Command to staart the app when the container starts
CMD ["node", "server.js"]
