# Ready to use Project for screenshots

This project should be used to make screenshots for the TYPO3 Documentation. See also
[Guidelines for creating images](https://docs.typo3.org/permalink/h2document:guidelines-for-images)

Prerequisites:

* Docker and DDEV
* Internet connection during installation and update

## Installation

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

## Delete the project from your system

```
make delete
```
