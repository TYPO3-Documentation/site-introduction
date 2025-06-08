# Ready to use Project for Screenshots

This project is intended to create consistent screenshots for the official TYPO3 Documentation.
For visual style guidance, refer to the
[Guidelines for creating images](https://docs.typo3.org/permalink/h2document:guidelines-for-images)

> [!WARNING]
> This is not suitable for production use. It is a demo installation meant for local or temporary usage only.

---

## 🚀 Quick Start Using Docker

You can run the screenshot project locally using the prebuilt Docker image:

```bash
docker run -d --name typo3-screenshots -p 8080:80 linawolf/typo3-screenshots
```

Follow the logs to track progress:

```bash
docker logs -f typo3-screenshots
```

Once setup is complete, open:

```
http://localhost:8080/typo3
```

**Login credentials:**

- **Username:** `j.doe`
- **Password:** `Password.1`

> [!NOTE]
> The container resets on every run. It’s ideal for reproducible test environments and fresh screenshots.

---

## 🔧 Development

If you want to build the container yourself, run it interactively, or work with DDEV or GitHub Codespaces, see:

👉 [DEVELOPMENT.md](./DEVELOPMENT.md)

---
