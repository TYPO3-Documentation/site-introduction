# Ready to use Project for screenshots

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://github.com/TYPO3-Documentation/site-introduction)

This project should be used to make screenshots for the TYPO3 Documentation. See also
[Guidelines for creating images](https://docs.typo3.org/permalink/h2document:guidelines-for-images)

> [!WARNING]
> Do not use this project for real world projects, it is just a quick way to create screenshots locally.

## Using GitHub Codespaces

You can use this project directly in [GitHub Codespaces](https://github.com/features/codespaces).

To get started:

1. Click the **"Code"** button on the [repository page](https://github.com/TYPO3-Documentation/site-introduction)
   and select **"Create Codespace on main"**.
3. Wait a few minutes while the container and environment are initialized.
4. Once ready, open the TYPO3 backend in your browser (Code spaces will show a popup)
5. Log in using the following credentials:

- **Username:** `j.doe`
- **Password:** `Password.1`

You're now logged in as an administrator and can start creating screenshots.


## Local Installation

Prerequisites:

* Docker and DDEV
* Internet connection during installation and update
  
```
ddev start
make install
```

A backend user called `j.doe` will be created for you. You can choose the password during the setup.

Log into the backend at

```
https://site-introduction.ddev.site/typo3
```

Currently, you have to switch the backend layout for the root page to default, we need to fix this
in the site package builder.

## Update

If there have been changes to the example data first delete and recreate the database:

```
make delete
```

Then regenerate the site package and update composer:

```
make update
```

## Create example editors

```
make create-editors
make update-page-permissions
```

## Delete the project from your system

```
make delete
```
