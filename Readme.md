---
theme: serif
revealOptions:
    transition: 'fade'
---
<!-- .slide: data-background="https://images.unsplash.com/photo-1514443031610-8c063c7a9822" data-state="intro"-->


# Timm's dotfiles

<time datetime="2020-05-29">May 2020</time>

In the great tradition of sharing dotfiles, this repository contains various configuration files for Unix and Linux software.


## Installation

### macOS
	curl -fsSL https://raw.githubusercontent.com/heussd/dotfiles/master/.onboard.sh | bash

### Ubuntu
	wget -O- https://raw.githubusercontent.com/heussd/dotfiles/master/.onboard.sh | bash



## What are dotfiles?

> In Unix-like operating systems, any file or folder that starts with a dot character [is] commonly called [a] dotfile [...].
>
>A convention arose of using dotfiles in the user's home directory to store per-user configuration or informational text.

[Wikipedia](https://en.wikipedia.org/wiki/Hidden_file_and_hidden_directory#Unix_and_Unix-like_environments)


### Example

~~~shell
➜ ls -la $HOME
total 18992
drwxr-xr-x+ 134 th    staff     4288 May 28 10:33 .
drwxr-xr-x    6 root  admin      192 Dec  5 09:21 ..
drwxr-xr-x   28 th    staff      896 May 25 21:56 .antigen
drwxr-xr-x   16 th    staff      512 Jan  2 19:37 .atom
-rw-------    1 th    staff     1070 Aug 16  2019 .bash_history
-rw-r--r--    1 th    staff       41 Jan  2 19:37 .bashrc
-rw-r--r--    1 th    staff     1624 May 26 10:55 .gitconfig
-rw-r--r--@   1 th    staff     2762 May  7 08:35 .opsify.json
-rw-r--r--    1 th    staff     3675 Apr  1 11:41 .vimrc
drwxr-xr-x    4 th    staff      128 Nov 15  2019 .vscode
-rw-r--r--    1 th    staff     3294 May 25 21:54 .zshrc
~~~

Note: Some stuff


### .gitconfig

	[alias]
		ac = !git add -u && git commit -m 
		cosh = !git commit && git push
		co = checkout
		s = status
		hist = log --pretty=format:\"%h %ad | %s%d [%an]\" --graph --date=short
		ref-ignore = !sh -c 'curl https://raw.githubusercontent.com/github/gitignore/master/'$1'.gitignore -o .gitignore'
		# https://thoughtbot.com/blog/powerful-git-macros-for-automating-everyday-workflows
	    branches = for-each-ref --sort=-committerdate --format=\"%(color:blue)%(authordate:relative)\t%(color:red)%(authorname)\t%(color:white)%(color:bold)%(refname:short)\" refs/remotes
		mru = for-each-ref --sort=-committerdate --count=10 refs/heads/ --format='%(HEAD) %(color:yellow)%(refname:short)%(color:reset) - %(color:red)%(objectname:short)%(color:reset) - %(contents:subject) - %(authorname) (%(color:green)%(committerdate:relative)%(color:reset))'
	    whatadded = log --diff-filter=A



## What are dotfile repositories?


### Culture of sharing
![People sharing their dotfile repositories on GitHub](dotfiles-search-on-github.png)


### Why?

> - Backup, restore, and sync the prefs and settings for your toolbox. Your dotfiles might be the most important files on your machine.
> - Learn from the community. Discover new tools for your toolbox and new tricks for the ones you already use.
> - Share what you’ve learned with the rest of us.

<https://dotfiles.github.io/>



## Timm's dotfiles


### 1 x dotfiles on...

- 2 x macOS (Intel)
- 2 x Ubuntu Linux (Intel)
- 1 x Raspbian Linux (ARM)


### Big Picture

![](components.png)


### Excursion: Makefiles


A Makefile consists of a set of **rules**. A rule generally looks like this:

~~~Makefile
targets : prerequisities
   command
   command
   command
~~~
<https://makefiletutorial.com/>


#### ⚠️ Two different kinds of targets ⚠️
~~~Makefile
blah: blah.c
	cc -c blah.c -o blah.o

blah.c:
	echo "int main() { return 0; }" > blah.c

clean:
	rm -f blah.o blah.c blah
~~~
<https://makefiletutorial.com/>


#### `.PHONY` marks targets as being indepedent from files

~~~Makefile
.PHONY: blah
blah: blah.c
	cc -c blah.c -o blah.o

blah.c:
	echo "int main() { return 0; }" > blah.c

.PHONY: clean
clean:
	rm -f blah.o blah.c blah
~~~
<https://makefiletutorial.com/>


#### Normal-prerequisites | Order-only-prerequisites

~~~Makefile
.PHONY: blah
blah: lib.o blah.c

.PHONY: blub check
blub: lib.o blah.c | check
~~~

<https://www.gnu.org/software/make/manual/html_node/Prerequisite-Types.html>



## Feature Highlights


### Git-native solution 🙌

	alias dotfiles='git --git-dir=$HOME/.dotfiles-bare-repo/ \
						--work-tree=$HOME/'

No additional tooling or symlink farm managers needed, a `checkout` deploys the files on their right position.


### Sparse checkout

~~~Makefile
@git --git-dir=$(DOTFILES_BARE_REPO) config --local \
				core.sparseCheckout true
# Include everything
@echo "/*" > $(DOTFILES_BARE_REPO)/info/sparse-checkout
# Exclude readme
@echo "!Readme.md" >> $(DOTFILES_BARE_REPO)/info/sparse-checkout
~~~

In the initial checkout, configure Sparse checkouts by default and ignore some files.

[Makefile#L34-L44](https://github.com/heussd/dotfiles/blob/30b09dc220a7cff4796579a07c9b5de29e34c7cb/Makefile#L34-L44)


### Auto update of dotfiles

	find .dotfiles-bare-repo/FETCH_HEAD -mmin +$$((7*24*60)) -exec \
			git --git-dir=$(DOTFILES_BARE_REPO) \
					--work-tree=$(DOTFILES_WORK_DIR)/ \
							pull --recurse-submodules \;
	
[Makefile#L85](https://github.com/heussd/dotfiles/blob/30b09dc220a7cff4796579a07c9b5de29e34c7cb/Makefile#L85)

Pull dotfiles automatically at least every 7 days.


### Auto update of packages 🔥🔥🔥

~~~Makefile
.PHONY: check-time-last-installed
check-time-last-installed:
	@if [ -e .auto-install-$(OS_NAME) ]; then
		find .auto-install-$(OS_NAME) -mmin +$$((7*24*60))
			-exec bash -c 'rm -f "{}"; 
					$(MAKE) .auto-install-$(OS_NAME)' \; ; fi

.auto-install-darwin: .Brewfile | check-time-last-installed
	@brew update
	@brew bundle install -v --file=.Brewfile
~~~

[Makefile#L93-L107](https://github.com/heussd/dotfiles/blob/30b09dc220a7cff4796579a07c9b5de29e34c7cb/Makefile#L93-L107)

Execute automatic update if package list got changed or last update is older than 7 days.


### Motto of the Day

~~~text
    _         _           _       _
   | | ____ _| |__  _   _| | __ _| | _____
   | |/ / _` | '_ \| | | | |/ _` | |/ / _ \
   |   < (_| | |_) | |_| | | (_| |   <  __/
   |_|\_\__,_|_.__/ \__, |_|\__,_|_|\_\___|
                    |___/

Mac OS X 10.15.4 19E287
dotfiles @ 30b09dc Changed VIM leader key to ,
 M .config/Code/User/settings.json
7fb4428b12f0  webpronl/reveal-md:latest  Up 34 hrs.  0.0.0.0:1948->1948/tcp
	
snippets master _   Added snippet
vimwiki  master     Solved merge conflict
~~~

host name, OS version, dotfiles version, dotfiles modifications, running Docker containers, [gita](https://github.com/nosarthur/gita) repository status, ZFS pool status


### Conditional statements

~~~bash
function _hasFile() { if [ -e "$1" ]; then return 0; fi; return 1; }
function _hasNotFile() { if [ -e "$1" ]; then return 1; fi; return 0; }
function _hasFolder() { if [ -d "$1" ]; then return 0; fi; return 1; }
function _hasCmd() { which "$1" &>/dev/null; }
function _isMacOS() { uname -s | grep "Darwin" > /dev/null; }
function _isLinux() { uname -s | grep "Linux" > /dev/null; }
~~~
[.shell-aliases#L5-L10](https://github.com/heussd/dotfiles/blob/30b09dc220a7cff4796579a07c9b5de29e34c7cb/.shell-aliases#L5-L10)

Do something depending on commands, files, folders, operating system.


#### Examples: `_hasCmd` / `_hasFile`

~~~bash
_hasCmd zpool && (
	zpool status && echo
)
~~~
[.shell-motd#L17-L19](https://github.com/heussd/dotfiles/blob/30b09dc220a7cff4796579a07c9b5de29e34c7cb/.shell-motd#L17-L19)

~~~bash
_hasFile ~/.fzf.zsh && source ~/.fzf.zsh
~~~
[.zshrc#L75](https://github.com/heussd/dotfiles/blob/30b09dc220a7cff4796579a07c9b5de29e34c7cb/.zshrc#L75)


#### Makefile native way

~~~Makefile
OS_NAME := $(shell uname -s | tr A-Z a-z)

auto-install: .auto-install-$(OS_NAME)
.auto-install-darwin: 
	...
~~~

[Makefile#L93-L107](https://github.com/heussd/dotfiles/blob/30b09dc220a7cff4796579a07c9b5de29e34c7cb/Makefile#L93-L107)


### Transparent Encryption

Most of my dotfiles can be shared, but some contain my personal preferences and interests which I do not want to expose to the public.

For those files, [transcrypt](https://github.com/elasticdog/transcrypt) is a nice solution.


#### Newsboat alias "tv"
~~~
alias tv="newsboat --config-file=$HOME/.newsboat/config-tv \
				   --url-file=$HOME/.newsboat/urls-tv"
~~~	

- config-tv is a dotfile I'm happy to share
- urls-tv is a dotfile I would rather not share


#### git-native solution with filter drivers

	.newsboat/urls-tv  filter=crypt diff=crypt merge=crypt

[.gitattributes#L2](https://github.com/heussd/dotfiles/blob/30b09dc220a7cff4796579a07c9b5de29e34c7cb/.gitattributes#L2)

Transcrypt registers a [git filter driver](https://git-scm.com/docs/gitattributes) that uses openssl to symmetrically encrypt and decrypt files between pushes and pulls.


### git submodules and symlinks

~~~text
➜ dotfiles submodule
66aac9 .dotfiles-externals/my-way-to-view-things (heads/master)
~~~

[my-way-to-view-things](https://github.com/heussd/my-way-to-view-things) repository as submodule

~~~text
➜ ls -la "Library/Application Support/MacDown/Styles/"
Timm's Way to View Things.css -> ../../../../.dotfiles-externals/my-way-to-view-things/text-reading.css
~~~

~~~text
➜ ls -ls "Library/Application Support/Vienna/Styles/Timms Document Style.viennastyle"
stylesheet.css -> ../../../../../../_externals/my-way-to-view-things/text-reading.css
~~~
Using it in various places with symlinks



## Conclusion

- Know, extend, configure the tools you use.
- Treat dotfiles as code
- Share dotfiles on GitHub


> Ein Mann, der recht zu wirken denkt, muß auf das beste Werkzeug halten.

Johann Wolfgang von Goethe


<https://github.com/heussd/dotfiles>



## Credits

This repository was inspired by many different sources. Here are the most relevant ones: 

- [StreakyCobra on Hacker News](https://news.ycombinator.com/item?id=11071754)
- [Sneak's hacks on GitHub](https://github.com/sneak/hacks/)
