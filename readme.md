# Timm's dotfiles

[![Babellint](https://github.com/heussd/dotfiles/actions/workflows/babellint.yml/badge.svg)](https://github.com/heussd/dotfiles/actions/workflows/babellint.yml)
[![Smoke Tests](https://github.com/heussd/dotfiles/actions/workflows/smoke-tests.yml/badge.svg)](https://github.com/heussd/dotfiles/actions/workflows/smoke-tests.yml)
[![Mirror to BitBucket](https://github.com/heussd/dotfiles/actions/workflows/mirror-to-bitbucket.yml/badge.svg)](https://github.com/heussd/dotfiles/actions/workflows/mirror-to-bitbucket.yml)


In the great tradition of sharing dotfiles, this repository contains various configuration files for Unix and Linux software.


## Installation


### macOS


```sh
curl -fsSL https://raw.githubusercontent.com/heussd/dotfiles/main/.onboard-dotfiles.sh | bash
```

### Ubuntu

```sh
wget -O- https://raw.githubusercontent.com/heussd/dotfiles/main/.onboard-dotfiles.sh | bash
```

### devcontainer.json

```json
"customizations": {
    "vscode": {
        "settings": {
            "dotfiles.repository": "https://github.com/heussd/dotfiles",
            "dotfiles.targetPath": "~/.dotfiles",
            "dotfiles.installCommand": ".onboard-dotfiles.sh",
        }
    }
}
```


## Credits

This repository was inspired by many different sources. Here are the most relevant ones:

- [Sneak's hacks on GitHub](https://github.com/sneak/hacks/)
- [StreakyCobra on Hacker News](https://news.ycombinator.com/item?id=11071754)
