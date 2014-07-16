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

PYTHONBIN=/Library/Frameworks/Python.framework/Versions/2.7/bin
# Set Python warnings back to the default level for Python 2.7+
export PYTHONWARNINGS="d"

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

# This is required to build certain things on OSX 10.6+
# export ARCHFLAGS="-arch i386 -arch x86_64"

# Pip
export PIP_RESPECT_VIRTUALENV=true
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

# Rackspace cloud
export RACKSPACE_USERNAME='TODO'
export RACKSPACE_KEY='TODO'

export NEWRELIC='TODO'

# AWS stuff
export AWS_ACCESS_KEY_ID='TODO'
export AWS_SECRET_ACCESS_KEY='TODO'

# Django
export DJANGO_SETTINGS_MODULE=settings.bz

# Add a few things
PATH=/usr/local/git/bin:/usr/local/bin:$HOME/.rvm/bin:$PATH:$HOME/bin:$PYTHONBIN

# For macports...this should be the last item to modify the path
export MANPATH=/opt/local/share/man:$MANPATH:/usr/local/mysql/man

# Java/Hadoop
JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home

# Add the git state into the prompt
export PS1='\u@\h$(__git_ps1 "(%s)")\$ '
GIT_PS1_SHOWUPSTREAM="auto"

export TERM=xterm-color
export SVN_EDITOR=vim
export EDITOR=vim

# Screen stuff
alias screen='TERM=screen screen'

# Hack in the psswds for mysql
alias mysql='mysql -pTODO'
alias mysqldump='mysqldump -pTODO'

### brianz aliases
alias ls='ls -G'
alias l='ls -lF'
alias la='ls -alF'
alias lt='ls -lFt'
alias p='pwd'
alias v='vim'
alias c='clear'
alias cd..='cd ..'
alias gpp='g++'
alias updb='sudo /usr/libexec/locate.updatedb'
alias stopmysql='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist'
alias startmysql='launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mysql.plist'
alias startmemcache='sudo launchctl load -w /Library/LaunchDaemons/org.macports.memcached.plist'
alias stopmemcache='sudo launchctl unload -w /Library/LaunchDaemons/org.macports.memcached.plist'
alias startrabbit='sudo launchctl load -w /Library/LaunchDaemons/org.macports.rabbitmq-server.plist'
alias vg='vagrant'
alias vup='vagrant up'
alias vdown='vagrant suspend'
alias cleanpyc="find . -name '*.pyc' | xargs rm"
alias list_ports="netstat -lnptu"

if [ -d /usr/local/Cellar/clojure-contrib/1.2.0 ]; then
    export CLASSPATH=$CLASSPATH:/usr/local/Cellar/clojure-contrib/1.2.0/clojure-contrib.jar
fi

function grepsrc () {
    find . -name "$1" | xargs egrep "$2";
}
