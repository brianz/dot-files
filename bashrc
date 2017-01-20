# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
if [ -f $HOME/.profile ]; then
    . $HOME/.profile
fi
# Key bindings
if [ -f $HOME/.bash_key_bindings ]; then
    bind -f $HOME/.bash_key_bindings
fi

# Git autocomplete
if [ -f $HOME/.git-completion ]; then
    source $HOME/.git-completion
    source $HOME/.git-prompt
fi

# for mac
# PYTHONBIN=/Library/Frameworks/Python.framework/Versions/2.7/bin
# Set Python warnings back to the default level for Python 2.7+
#export PYTHONWARNINGS="d"

# VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
# for mac
# VIRTUALENVWRAPPER_PYTHON=/Library/Frameworks/Python.framework/Versions/2.7/bin/python

# Virtualenv wrappers.  Make sure this directory has been created already.
export WORKON_HOME=$HOME/.virtualenvs
if [ ! -d $WORKON_HOME ]; then
    mkdir $WORKON_HOME
fi

VENV_SH=/usr/local/bin/virtualenvwrapper.sh
if [ -f $VENV_SH ]; then
    source $VENV_SH;
fi

if [ -f $HOME/.bbucket ]; then
    source $HOME/.bbucket
fi

if [ -f $HOME/.tmuxinator.bash ]; then
    source $HOME/.tmuxinator.bash
fi

# This is required to build certain things on OSX 10.6+
# export ARCHFLAGS="-arch i386 -arch x86_64"

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

export HISTFILESIZE=3000
export LSCOLORS=cxfxcxdxbxegedabagacad

# GOLANG
export GOPATH=$HOME/go
if [ ! -d $GOPATH ]; then
    mkdir $GOPATH
fi

# Add a few things
PATH=/usr/local/git/bin:/usr/local/bin:/usr/local/sbin:$GOPATH/bin:$HOME/.rvm/bin:$PATH:$HOME/bin:$PYTHONBIN

# Java/Hadoop
JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home

# Add the git state into the prompt
export PS1='\u@\h$(__git_ps1 "(%s)")\$ '
GIT_PS1_SHOWUPSTREAM="auto"

# Deal with bash completions
for fn in `ls /usr/local/etc/bash_completion.d`; do
    source /usr/local/etc/bash_completion.d/$fn
done

if [[ -z "$TMUX" ]]; then
    export TERM=xterm-256color
fi
export SVN_EDITOR=vim
export EDITOR=vim

export DO_TOKEN=
export GITHUB_TOKEN=
export HOMEBREW_GITHUB_API_TOKEN=$GITHUB_TOKEN
export EXERCISM_KEY=

export NEWRELIC_API_KEY=

export SPARTAN_SLACK_TOKEN=

# Screen stuff
alias screen='TERM=screen screen'

### brianz aliases
alias ls='ls -G'
alias l='ls -lF'
alias la='ls -alF'
alias lt='ls -lFt'
alias p='pwd'
alias v='vim'
alias c='clear'
alias grep="egrep --color=auto"
alias egrep="egrep --color=auto"
alias cd..='cd ..'
alias gpp='g++'
alias updb='sudo /usr/libexec/locate.updatedb'
alias vg='vagrant'
alias vup='vagrant up'
alias vdown='vagrant suspend'
alias cleanpyc="find . -name '*.pyc' | xargs rm"
alias list_ports="netstat -lnptu"
alias wanip='dig +short myip.opendns.com @resolver1.opendns.com'
alias tm='tmux'
alias camerakill='sudo killall VDCAssistant'
alias weather='curl wttr.in/fnl'

function restartdnsmasq() {
    sudo launchctl stop homebrew.mxcl.dnsmasq;
    sudo launchctl start homebrew.mxcl.dnsmasq;
}

if [ -d /usr/local/Cellar/clojure-contrib/1.2.0 ]; then
    export CLASSPATH=$CLASSPATH:/usr/local/Cellar/clojure-contrib/1.2.0/clojure-contrib.jar
fi

function export_aws_keys() {
    export AWS_KEY_PAIR="brianz-aws-console"
    export AWS_DEFAULT_REGION="us-west-2"
    if [[ "$1" == "rlog" ]]; then
        export AWS_KEY_PAIR="brianz-roastlog"
        export AWS_ACCESS_KEY_ID=
        export AWS_SECRET_ACCESS_KEY=
    elif [[ "$1" == "bz" ]]; then
        export AWS_ACCESS_KEY_ID=
        export AWS_SECRET_ACCESS_KEY=
    else
        export AWS_DEFAULT_REGION=
        export AWS_ACCESS_KEY_ID=
        export AWS_SECRET_ACCESS_KEY=
    fi
}
function export_intercom_keys() {
    if [[ "$1" == "prod" ]]; then
        export INTERCOM_KEY='PROD'
        export INTERCOM_APPID='PROD'
        export INTERCOM_TOKEN='PROD='
    else
        # test creds
        export INTERCOM_KEY='TEST'
        export INTERCOM_APPID='TEST'
        export INTERCOM_TOKEN='TEST='
    fi
}

function grepsrc () {
    find . -name "$1" | xargs egrep "$2";
}

function gistme() {
    gist -p -s -c -f $1 $@
}

function shorturl() {
    if [[ ! $1 ]]; then
        return
    fi

    code=${2:-}
    response=$(curl -i -s -L https://git.io \
        -F "url=$1" \
        -F "code=$code")
    echo $response
    #| grep Location | awk '{print $2}')

    echo $url | pbcopy
    echo $url
}

function gitsha() {
    gitsha=`git log -1 --format=%h`
    echo $gitsha
    echo $gitsha | pbcopy
}

function clean_venv() {
    deactivate && rmvirtualenv $1 && mkvirtualenv $1
}


function vundle_install() {
    vim +PluginInstall +qall
}

function dclean() {
    docker rm -v $(docker ps -a -q -f status=exited) 2> /dev/null
    docker rmi $(docker images -f "dangling=true" -q) 2> /dev/null
}


export_aws_keys bz
export_intercom_keys 
