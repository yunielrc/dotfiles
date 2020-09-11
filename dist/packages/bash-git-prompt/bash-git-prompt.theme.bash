if [ -f ~/.bash-git-prompt/gitprompt.sh ]; then
    export GIT_PROMPT_ONLY_IN_REPO=1
    . ~/.bash-git-prompt/gitprompt.sh
    export GIT_PROMPT_THEME=Solarized
fi
