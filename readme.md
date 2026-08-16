# Timm's dotfiles

[![Babellint](https://github.com/heussd/dotfiles/actions/workflows/babellint.yml/badge.svg)](https://github.com/heussd/dotfiles/actions/workflows/babellint.yml)
[![Pre-commit](https://github.com/heussd/dotfiles/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/heussd/dotfiles/actions/workflows/pre-commit.yml)
[![Smoke Tests](https://github.com/heussd/dotfiles/actions/workflows/smoke-tests.yml/badge.svg)](https://github.com/heussd/dotfiles/actions/workflows/smoke-tests.yml)

In the great tradition of sharing dotfiles, this repository contains various configuration files for Unix and Linux software.

## Installation

### macOS

```sh
curl -fsSL https://raw.githubusercontent.com/heussd/dotfiles/main/.install.sh | bash
```

### Ubuntu

```sh
wget -O- https://raw.githubusercontent.com/heussd/dotfiles/main/.install.sh | bash
```

### devcontainer.json

```json
"customizations": {
    "vscode": {
        "settings": {
            "dotfiles.repository": "https://github.com/heussd/dotfiles",
            "dotfiles.targetPath": "~/.dotfiles",
            "dotfiles.installCommand": ".install.sh",
        }
    }
}
```

## Credits

This repository was inspired by many different sources. Here are the most relevant ones:

- [Sneak's hacks on GitHub](https://github.com/sneak/hacks/)
- [StreakyCobra on Hacker News](https://news.ycombinator.com/item?id=11071754)
