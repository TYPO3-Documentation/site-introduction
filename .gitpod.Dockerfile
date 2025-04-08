# .gitpod.Dockerfile
FROM gitpod/workspace-php:latest

# Install SQLite PHP extension (if not already present)
RUN sudo apt-get update && sudo apt-get install -y php-sqlite3
