function prompt_pwd {
	case "$PWD" in
		"$HOME") echo "~";;
		*)
			printf "%s" $(echo $PWD|sed -e "s|^$HOME|~|" -e 's-/\(\.\{0,1\}[^/]\)\([^/]*\)-/\1-g');
			echo $PWD|sed -n -e 's-.*/\.\{0,1\}.\([^/]*\)-\1-p';;
	esac; }

function prompt_host {
    local maxlen=3
	echo "$(echo $HOSTNAME | cut -c 1-$maxlen)"
}

function prompt_user {
    local maxlen=3
	echo "$(whoami | cut -c 1-$maxlen)"
}

function bash_prompt_command() {
	NEW_PWD=$(prompt_pwd)
    # How many characters of the $PWD should be kept
    # local pwdmaxlen=25
    # Indicate that there has been dir truncation
    # local trunc_symbol=".."
    # local dir=${PWD##*/}
    # pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
    # NEW_PWD=${PWD/#$HOME/\~}
    # local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
    # if [ ${pwdoffset} -gt "0" ]
    # then
    #     NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
    #     NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
    # fi
	NEW_HOST=$(prompt_host)
	NEW_USER=$(prompt_user)
}
 
bash_prompt() {
    case $TERM in
     xterm*|rxvt*)
         local TITLEBAR='\[\033]0;\u:${NEW_PWD}\007\]'
          ;;
     *)
         local TITLEBAR=""
          ;;
    esac
    local NONE="\[\033[0m\]"    # unsets color to term's fg color
 
    # regular colors
    local K="\[\033[0;30m\]"    # black
    local R="\[\033[0;31m\]"    # red
    local G="\[\033[0;32m\]"    # green
    local Y="\[\033[0;33m\]"    # yellow
    local B="\[\033[0;34m\]"    # blue
    local M="\[\033[0;35m\]"    # magenta
    local C="\[\033[0;36m\]"    # cyan
    local W="\[\033[0;37m\]"    # white
 
    # emphasized (bolded) colors
    local EMK="\[\033[1;30m\]"
    local EMR="\[\033[1;31m\]"
    local EMG="\[\033[1;32m\]"
    local EMY="\[\033[1;33m\]"
    local EMB="\[\033[1;34m\]"
    local EMM="\[\033[1;35m\]"
    local EMC="\[\033[1;36m\]"
    local EMW="\[\033[1;37m\]"
 
    # background colors
    local BGK="\[\033[40m\]"
    local BGR="\[\033[41m\]"
    local BGG="\[\033[42m\]"
    local BGY="\[\033[43m\]"
    local BGB="\[\033[44m\]"
    local BGM="\[\033[45m\]"
    local BGC="\[\033[46m\]"
    local BGW="\[\033[47m\]"
 
    local UC=$W                 # user's color
    [ $UID -eq "0" ] && UC=$R   # root's color

#    PS1="$TITLEBAR${EMK}${UC}\u${EMK}@${UC}\h ${EMB}\${NEW_PWD}${EMK} ${UC}\\$ ${NONE}" 
    PS1="$TITLEBAR${EMK}${UC}\${NEW_USER}${EMK}@${UC}\${NEW_HOST} ${EMB}\${NEW_PWD}${EMK} ${UC}\\$ ${NONE}"
    # without colors: PS1="[\u@\h \${NEW_PWD}]\\$ "
    # extra backslash in front of \$ to make bash colorize the prompt
}
# init it by setting PROMPT_COMMAND
PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt

export HISTTIMEFORMAT="%s "
PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND ; }"'echo $$ $USER \
               "$(pwd) $(history 1)" >> ~/.bash_eternal_history'
