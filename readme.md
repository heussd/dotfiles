# Timm's dotfiles

[![Babellint](https://github.com/heussd/dotfiles/actions/workflows/babellint.yml/badge.svg)](https://github.com/heussd/dotfiles/actions/workflows/babellint.yml)
[![Smoke Tests](https://github.com/heussd/dotfiles/actions/workflows/smoke-tests.yml/badge.svg)](https://github.com/heussd/dotfiles/actions/workflows/smoke-tests.yml)
[![Mirror to BitBucket](https://github.com/heussd/dotfiles/actions/workflows/mirror-to-bitbucket.yml/badge.svg)](https://github.com/heussd/dotfiles/actions/workflows/mirror-to-bitbucket.yml)

In the great tradition of sharing dotfiles, this repository contains various configuration files for Unix and Linux software.

## Feature highlights

- Automatic sync and installation of macOS preferences and the Dock.
- Automatic sync of installed items with brew, stew, pip, Docker images, VS Code extensions and apt.
- Automatic, rudimentary steam-tests with GitHub Actions.
- Automatic, scheduled update installation with brew and pip.
- Cross-OS (Linux, macOS) and cross-architecture (ARM, x64) compatibility.
- Developer and power-user brewfile with CPU-architecture- and OS-specific instructions.
- Fine-tuned configurations for kitty, newsboat, zsh, vim, git and Firefox.
- Git-native versioning, syncing and deployment of dotfiles.
- Installation with one command on Linux, macOS and devcontainers.
- Motto-of-the-day in the shell to show version info and git status.
- Tearless, Kernel-extension-free Hyper-key in macOS with Hammerspoon and launch-service.


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
