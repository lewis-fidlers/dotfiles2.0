# Start rbenv
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Make vim the default editor
export EDITOR='vim'
# Settings for nvm (node version manager)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# Add homebrew arm to path
if [ -d "/opt/homebrew/bin" ]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

# ibrew to install intel based version of the package
function ibrew() {
   arch --x86_64 /usr/local/bin/brew $@
}

# Add awscli and kubectl to path
export PATH=~/Library/Python/3.7/bin:$HOME/bin:$HOME/.bin:$PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set language
export LC_ALL=en_US.UTF-8

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git --ignore node_modules -g ""'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Where the vault server is running
export VAULT_ADDR="http://127.0.0.1:8200"

# Source some aws session variables
# source ~/.aws/mfa

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

DEFAULT_USER=`whoami`

# Aliases
alias b="bundle"
alias bi="b install --path vendor"
alias bil="bi --local"
alias bu="b update"
alias be="b exec"
alias binit="bi && b package && echo 'vendor/ruby' >> .gitignore"

alias v="open -a MacVim.app ."
alias mvim="open -a MacVim.app ."

alias home="cd ~"
alias spreds="cd ~/projects/spreds"
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"

#Git aliases
alias git='hub'
alias gpr='git pull-request -b master'
alias gco='git checkout'
alias gp='git push'
alias gl='git pull'
alias gca='git commit -a'
alias gc='git commit'
alias sup='git push --set-upstream origin HEAD'
alias g-='gco -'

#jruby
# alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
# alias j12="export JAVA_HOME=`/usr/libexec/java_home -v 12`; java -version"

# Kubernetes
alias k=kubectl

today () {
  $(date '+%d%m%y')
}

now () {
  (date '+%H%M')
}

ladida () {
  url="https://bd8wz9ifl5.execute-api.eu-west-3.amazonaws.com/Production/%7Bladida+%7D"
  curl -G -s \
    --data-urlencode "text=$*" \
    $url | pbcopy
}

bane () {
  quote="You merely adopted the dark. I was born in it, molded by it. I didn't see the light until I was already a man, by then it was nothing to me but blinding!"
  result=${quote//dark/$*}
  echo $result
}

alias timetogo="open -a 'Google Chrome' 'https://irail.be/route?to=http%3A%2F%2Firail.be%2Fstations%2FNMBS%2F008821121&from=http%3A%2F%2Firail.be%2Fstations%2FNMBS%2F008819406&date=$today&time=$now&timeSel=depart'"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/opt/mysql@5.7/bin:$PATH"
