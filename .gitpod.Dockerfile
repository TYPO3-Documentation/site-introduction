# .gitpod.Dockerfile
FROM gitpod/workspace-full-php:latest

# Install SQLite support
RUN sudo apt-get update && sudo apt-get install -y php-sqlite3
