# Dockerfile 1: Default Behavior
FROM nginx:latest
ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]
