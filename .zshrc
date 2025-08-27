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
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

HIST_STAMPS=yyyy-mm-dd

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(
        ant
        bgnotify
        bundler
        capistrano
        direnv
        docker
        docker-compose
        fluxcd
        fzf
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
)
manager_plugins=(rvm nvm sdkman phpbrew)
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:${HOME}/bin
if [ -n "$(command -v vim)" ]; then
    export EDITOR="$(command -v vim)"
elif [ -x /usr/bin/editor ]; then
    export EDITOR=/usr/bin/editor
fi

if [ -d "${HOME}/.zsh.d" ]; then
    for mplug  in "${manager_plugins[@]}"; do
        source "${HOME}/.zsh.d/${mplug}.zsh"
    done
fi


[[ -e "$HOME/.aliases" ]] && source "$HOME/.aliases"


alias mvn='mvn-color'
unalias ls 2>/dev/null || true

LS_OPTIONS="-A -N --color=tty -T 0 --group-directories-first"
# shellcheck disable=SC2139
alias ls="ls $LS_OPTIONS"

[ -n "$GNOME_DESKTOP_SESSION_ID" ] && cat /etc/motd

[ -d "${HOME}/.yarn/bin" ] && export PATH="${HOME}/.yarn/bin:${PATH}"

type direnv > /dev/null && eval "$(direnv hook zsh)"

if [ -n "${SSH_CLIENT}" ]; then
    [ -f "$HOME/bin/set_dbus_addres_ssh.sh" ] && eval "$($HOME/bin/set_dbus_addres_ssh.sh)"
fi

if [ -z "${SSH_AUTH_SOCK}" ] && [ -S "${XDG_RUNTIME_DIR}/gcr/ssh" ]; then
    echo ' >> Fixing Gnome Keyring Manager SSH stuff'
    export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gcr/ssh"
    export SSH_ASKPASS=/usr/lib/seahorse/ssh-askpass

    if ! ssh-add -l | grep -Fq 'i4QAUe3g2w7UGEhFOs/o9FJ/0vbSMdTfAEqCnbFr47A' ; then
        echo ' >> Adding default RSA key after reboot'
        ssh-add "${HOME}/.ssh/id_rsa"
    fi

fi


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then
    export USE_GKE_GCLOUD_AUTH_PLUGIN=True
    . '/opt/google-cloud-sdk/path.zsh.inc';
fi

[ -d "${HOME}/.krew/bin" ] && export PATH="${HOME}/.krew/bin:${PATH}"

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/google-cloud-sdk/completion.zsh.inc'; fi

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
   source "$(code --locate-shell-integration-path zsh)"
fi
