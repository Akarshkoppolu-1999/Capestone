# Stage 1: Serving stage
FROM nginx:alpine

# Security: Non-root user in nginx is tricky but we can use alpine features
# Copy static files
COPY . /usr/share/nginx/html

# Custom nginx config to proxy API requests
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
