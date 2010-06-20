# .bashrc

# User specific aliases and functions
if [ -f $HOME/.profile ]; then
    . $HOME/.profile
fi
# Key bindings
if [ -f $HOME/.bash_key_bindings ]; then
    bind -f $HOME/.bash_key_bindings
fi

# Virtualenv wrappers.  Make sure this directory has been created already.
export WORKON_HOME=$HOME/.virtualenvs
source /usr/local/bin/virtualenvwrapper_bashrc

# Pip
export PIP_RESPECT_VIRTUALENV=true
#export PIP_REQUIRE_VIRTUALENV=true
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

# Add a few things
PATH=$PATH:$HOME/bin:/usr/local/bin:/usr/local/sbin/
PATH=$PATH:/usr/local/mysql/bin/:/usr/local/git/bin/:/usr/local/mongodb/bin

# For macports...this should be the last item to modify the path
export MANPATH=/opt/local/share/man:$MANPATH:/usr/local/mysql/man

export PS1="\u@\h\$ "
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


function invoke-rc.d() {
    program="$1";
    command="$2";
    path="/Library/LaunchDaemons"
    cmd="launchctl ${command} -w $path/org.macports.${program}.plist"

    echo $cmd;
    `sudo $cmd`;
}


# EOF
