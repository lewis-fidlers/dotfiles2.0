# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/zafidlle/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/zafidlle/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/zafidlle/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/Users/zafidlle/.fzf/shell/key-bindings.zsh"
