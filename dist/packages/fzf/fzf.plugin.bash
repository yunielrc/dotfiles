# Setup fzf
# ---------
if [[ ! "$PATH" == */home/linuxbrew/.linuxbrew/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/linuxbrew/.linuxbrew/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.bash"

# Environment
# export FZF_DEFAULT_COMMAND='fd --hidden --follow --no-ignore --exclude .git'
export FZF_DEFAULT_COMMAND='find'
export FZF_COMPLETION_TRIGGER='**'
export FZF_DEFAULT_OPTS='--multi --height 50% --layout=reverse --border'

# Supported commands
# usage: _fzf_setup_completion path|dir|var|alias|host COMMANDS...
_fzf_setup_completion path bat
