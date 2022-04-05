# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
#ZSH_THEME='gianu'
ZSH_THEME='hron84'

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
        ant
        bundler
        capistrano
        direnv
        docker
        docker-compose
        git
        gvm
        history
        hron84
        knife
        kubectl
        kubectx
        mvn
        rake
        ruby
        vagrant
        zsh-autosuggestions
)
manager_plugins=(rvm nvm sdkman phpbrew)
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:${HOME}/bin
export EDITOR=/usr/bin/editor


# export PATH="$PATH:$HOME/.rvm/bin"
#export SDKMAN_DIR="${HOME}/.sdkman"
#[[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]] && source "${HOME}/.sdkman/bin/sdkman-init.sh"
#
#[[ -e "$HOME/.nvm/nvm.sh" ]] && . "$HOME/.nvm/nvm.sh" # This loads NVM
#
#[[ -e "$HOME/.phpbrew/bashrc" ]] && source "$HOME/.phpbrew/bashrc"

for mplug  in ${manager_plugins[@]}; do
    source "${HOME}/.zsh.d/${mplug}.zsh"
done


[[ -e "$HOME/.aliases" ]] && source "$HOME/.aliases"


alias mvn='mvn-color'
unalias ls 2>/dev/null || true

LS_OPTIONS="-A -N --color=tty -T 0 --group-directories-first"
alias ls="ls $LS_OPTIONS"

[ -n "$GNOME_DESKTOP_SESSION_ID" ] && cat /etc/motd

export PERL_LOCAL_LIB_ROOT="$PERL_LOCAL_LIB_ROOT:/home/hron/perl5";
export PERL_MB_OPT="--install_base /home/hron/perl5";
export PERL_MM_OPT="INSTALL_BASE=/home/hron/perl5";
export PERL5LIB="/home/hron/perl5/lib/perl5:$PERL5LIB";
export PATH="/home/hron/perl5/bin:$PATH";

type direnv > /dev/null && eval "$(direnv hook zsh)"

if [ -n "${SSH_CLIENT}" ]; then
    [ -f "$HOME/bin/set_dbus_addres_ssh.sh" ] && eval "$($HOME/bin/set_dbus_addres_ssh.sh)"
fi

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion