FROM nginx:alpine
COPY ui /usr/share/nginx/html  # Serve static frontend
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
