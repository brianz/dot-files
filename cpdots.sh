for fn in bash_key_bindings bashrc gitconfig gitignore screenrc vimrc; do
    #cp ~/.$fn $fn;
    cp $fn ~/.$fn;
done

# Setup new machine
curl https://raw.github.com/git/git/master/contrib/completion/git-completion.sh -o ~/.git-completion
curl https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh -o ~/.git-prompt

