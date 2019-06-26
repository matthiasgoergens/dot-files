# alias moreswap='swapfile=`mktemp /tmp/swapXXXX` && sudo touch $swapfile && sudo dd bs=512 count=1M if=/dev/zero | tee $swapfile | pv -s 512M && sudo mkswap $swapfile && sudo swapon $swapfile'
# alias ec='emacsclient'
# alias ecn='emacsclient -n'
alias vim=nvim
alias make=gmake
alias groot='cd $(git groot)'
alias devdiff='git diff --histogram --ignore-all-space  $(git merge-base origin/develop HEAD)'
alias make=gmake
alias find=gfind
