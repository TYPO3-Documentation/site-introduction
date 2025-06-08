# Development Guide

This document contains information for contributors and developers working on the TYPO3 Screenshot Project.

## Overview

This project is used to generate a preconfigured TYPO3 installation for taking consistent screenshots. The container
is stateless and resets itself on each run using an embedded SQLite database. You can either build it locally with
Docker, or use DDEV and Codespaces for development.

---

## 🚧 Local Development with Docker

You can build and run the project manually during development using Docker. This setup includes a SQLite database that is reset on each run.

### Build the container

```bash
docker build -t typo3-screenshots-standalone .
```

### Run the container

```bash
docker run -d --name typo3-screenshots-standalone -p 8080:80 typo3-screenshots-standalone
```

### View logs

```bash
docker logs -f typo3-screenshots-standalone
```

### Access the container shell

```bash
docker exec -it typo3-screenshots-standalone bash
```

### Run interactively (for debugging)

```bash
docker run --rm -it -p 8080:80 typo3-screenshots-standalone
```

---

## 💻 Using GitHub Codespaces

You can also develop directly in [GitHub Codespaces](https://github.com/features/codespaces):

1. Click **"Code"** on the [repository page](https://github.com/TYPO3-Documentation/site-introduction) and choose **"Create Codespace on main"**.
2. Wait for the Codespace to initialize.
3. Once ready, open the TYPO3 backend in your browser (a popup will appear).
4. Log in using:

    - **Username:** `j.doe`
    - **Password:** `Password.1`

To restart the environment after resuming a Codespace:

```bash
ddev start
```

---

## 🐳 Local Installation with DDEV

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/)
- [DDEV](https://ddev.readthedocs.io/)
- Internet connection for downloading packages and dependencies

### Start the project

```bash
ddev start
make install
```

Log into the backend:

```
https://site-introduction.ddev.site/typo3
```

**Credentials:**

- **Username:** `j.doe`
- **Password:** You choose this during install

> ⚠️ You may need to switch the backend layout of the root page to "default" manually. This will be fixed in the site package builder.

---

## 🔄 Updating the project

If you want to refresh the database and regenerate assets:

```bash
make delete
make update
```

This will delete the database, regenerate the site package, and update Composer dependencies.

---

## 👥 Create example editors

Run the following commands to create demo backend users:

```bash
make create-editors
make update-page-permissions
```

---

## 🧹 Clean up the project

To remove everything:

```bash
make delete
```

---

## 📦 Publishing your Docker Image

To tag and push your own image to Docker Hub:

```bash
docker build -t yourname/typo3-screenshots .
docker push yourname/typo3-screenshots
```

Then others can run:

```bash
docker run -d -p 8080:80 yourname/typo3-screenshots
```
