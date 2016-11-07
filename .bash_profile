PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

alias vim=nvim

PATH="$HOME/.local/bin:$PATH"

eval "$(stack --bash-completion-script stack)"

export HOMEBREW_GITHUB_API_TOKEN=1b740ca48aa54a7d59a5720e60d61c4b3789c21f
