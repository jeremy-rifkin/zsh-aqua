# Installing ZSH

This guide will show you how to install ZSH.

## Contents
- [Installing ZSH](#installing-zsh)
    - [Contents](#contents)
- [Installing on Linux](#installing-on-linux)
    - [Debian / Ubuntu](#debian--ubuntu)
    - [Red Hat / Cent OS](#red-hat--cent-os)
    - [Arch](#arch)
    - [Fedora](#fedora)
    - [Suse](#suse)
- [Installing on Mac](#installing-on-mac)
- [Installing on Windows](#installing-on-windows)
- [Set ZSH as your default shell](#set-zsh-as-your-default-shell)

# Installing on Linux

## Debian / Ubuntu

```bash
sudo apt update
sudo apt upgrade
sudo apt install zsh
```

## Red Hat / Cent OS

```bash
sudo yum update
sudo yum install zsh
```

## Arch

```bash
pacman -S zsh
```

## Fedora

```bash
dnf install zsh
```

## Suse

```bash
sudo zypper upgrade
sudo zypper install zsh
```

# Installing on Mac

First [install Homebrew](https://brew.sh/). Then:
```bash
brew install zsh
```

# Installing on Windows

![Lol](https://media.giphy.com/media/10JhviFuU2gWD6/source.gif)

Your best bet is probably [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10).

# Set ZSH as your default shell

```bash
chsh -s /bin/zsh
```
