# Dockerfile

# Base image
FROM nginx:latest

# Copy hello.txt to Nginx root directory
COPY hello.txt /var/www/

# Expose port 80
EXPOSE 80
