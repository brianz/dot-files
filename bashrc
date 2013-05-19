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
    . $HOME/.git-completion
fi

PYTHONBIN=/Library/Frameworks/Python.framework/Versions/2.6/bin
# Set Python warnings back to the default level for Python 2.7+
export PYTHONWARNINGS="d"

# Virtualenv wrappers.  Make sure this directory has been created already.
export WORKON_HOME=$HOME/.virtualenvs
if [ ! -d $WORKON_HOME ]; then
    mkdir $WORKON_HOME
fi
if [ -f $PYTHONBIN/virtualenvwrapper.sh ]; then
    source $PYTHONBIN/virtualenvwrapper.sh;
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

export COPENSTACK_COMPUTE_USERNAME="TODO"
export COPENSTACK_COMPUTE_API_KEY="TODO"

# Add a few things
PATH=$PATH:$HOME/bin:/usr/local/bin:$PYTHONBIN:/usr/local/git/bin/

# For macports...this should be the last item to modify the path
export MANPATH=/opt/local/share/man:$MANPATH:/usr/local/mysql/man

# Java/Hadoop
JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home

# Add the git state into the prompt
export PS1='\u@\h $(__git_ps1 "(%s)")\$ '

export TERM=xterm-color
export SVN_EDITOR=vim
export EDITOR=vim

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
alias cd..='cd ..'
alias gpp='g++'
alias updb='sudo /usr/libexec/locate.updatedb'
alias stopmysql='sudo launchctl unload -w /Library/LaunchDaemons/com.mysql.mysqld.plist'
alias startmysql='sudo launchctl load -w /Library/LaunchDaemons/com.mysql.mysqld.plist'
alias startmemcache='sudo launchctl load -w /Library/LaunchDaemons/org.macports.memcached.plist'
alias stopmemcache='sudo launchctl unload -w /Library/LaunchDaemons/org.macports.memcached.plist'
alias startrabbit='sudo launchctl load -w /Library/LaunchDaemons/org.macports.rabbitmq-server.plist'
alias startmongo='sudo mongod --fork --dbpath /usr/local/mongodb/data --logpath /var/log/mongod.log --logappend'

if [ -d /usr/local/Cellar/clojure-contrib/1.2.0 ]; then
    export CLASSPATH=$CLASSPATH:/usr/local/Cellar/clojure-contrib/1.2.0/clojure-contrib.jar
fi

function grepsrc () {
    find . -name "$1" | xargs egrep "$2";
}

# EOF
