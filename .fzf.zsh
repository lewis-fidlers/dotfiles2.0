# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/lewisfidlers/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/lewisfidlers/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/lewisfidlers/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/lewisfidlers/.fzf/shell/key-bindings.zsh"

