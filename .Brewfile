# Software I like
#
# When changing this file, you might also want to change these files:
# ~/.macos-dock
#

tap "homebrew/bundle"

brew "git"
brew "gh" # GitHub cli
brew "neovim"
brew "fzf" # Needed because apt version is too old for vim
brew "ripgrep" # Also needed for vim


if system 'uname -s | grep "Darwin" > /dev/null'
  instance_eval(File.read(".config/brew/Brewfile.darwin"))

  if system 'uname -p | grep "i386" > /dev/null'
    cask "macfuse" # macfuse is still the best choice for non-arm Macs
  end
  if system 'uname -p | grep "arm" > /dev/null'
    # userspace implementation of FUSE, replaces macfuse
    tap "macos-fuse-t/homebrew-cask"
    cask "fuse-t"
  end

  if system 'hostname | grep "kabylake" > /dev/null'
    instance_eval(File.read(".config/brew/Brewfile.kabylake"))
  else
    instance_eval(File.read(".config/brew/Brewfile.development"))
    instance_eval(File.read(".config/brew/Brewfile.work"))
  end
end


if system 'which code &> /dev/null'
  instance_eval(File.read(".config/brew/Brewfile.vscode"))
end

