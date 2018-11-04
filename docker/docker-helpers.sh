#!/bin/bash

# docker-helpers.#!/bin/sh
# - bash-completion for docker engine
# - install docker-machine with bash_completion
# - install docker-compose with bash_completion

## Notes
# Use `sudo install docker-helpers.sh /usr/local/bin`
# https://iridakos.com/tutorials/2018/03/01/bash-programmable-completion-tutorial.html

# Set source URLS
DM_BASE=https://github.com/docker/machine/releases/download/v0.15.0
DM_BASH=https://raw.githubusercontent.com/docker/machine/v0.15.0
DC_BASE=https://github.com/docker/compose/releases/download/1.21.2
DC_BASH=https://raw.githubusercontent.com/docker/compose/1.21.2/contrib/completion/bash
DK_BASH=https://raw.githubusercontent.com/docker/docker-ce

function set_vagrant {
  echo "INFO: Add bash completion for docker-compose"
  sudo curl -s -L $DC_BASH/docker-compose -o /etc/bash_completion.d/docker-compose

  echo "INFO: Add aliases for docker compose"
  echo "alias dc='docker-compose'" >> $HOME/.bash_aliases
  echo "complete -F _docker_compose dc" >> $HOME/.bash_aliases

  echo "INFO: Add bash completion for docker engine"
  sudo curl -s -L $DK_BASH/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
  echo "INFO: Add aliases for docker engine"
  echo "alias dk='docker'" >> $HOME/.bash_aliases
  echo "complete -F _docker dk" >> $HOME/.bash_aliases
  echo "alias dk-ps='docker ps --format \"table {{.ID}}\t{{.Image}}\t{{.Status}}\"'" >> $HOME/.bash_aliases

  exit 0
}

# Declare functions
function set_docker_machine {
  echo "INFO: Install docker-machine"
  curl -s -L $DM_BASE/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine
  sudo install /tmp/docker-machine /usr/local/bin/docker-machine
  rm /tmp/docker-machine
  echo "INFO: Add bash completion for docker-machine"
  for i in docker-machine-prompt.bash docker-machine-wrapper.bash docker-machine.bash
  do
    sudo curl -s -L "$DM_BASH/contrib/completion/bash/${i}" -o /etc/bash_completion.d/${i}
  done

  echo "INFO: Alias docker-machine to dm"
  echo "alias dm='docker-machine'" >> $HOME/.bash_aliases
  echo "complete -F _docker_machine dm" >> $HOME/.bash_aliases

  echo "INFO: Install shell helpers to .bashrc"

  cat <<'EOF' >> $HOME/.bashrc

# Inidus shell additions
# Set docker environment vars using docker-machine env <node.name>
function dm-set() {
  eval "$(docker-machine env "${1:-default}")"
}
# Unset docker environment vars
function dm-unset() {
  eval "$(docker-machine env -u)"
}
# Set shell prompt based on docker-machine
PS1='[\u@\h \W$(__docker_machine_ps1)]\$ '

EOF
  exit 0
}

function set_docker_compose {
  echo "INFO: Install docker-compose"
  sudo curl -s -L $DC_BASE/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  echo "INFO: Add bash completion for docker-compose"
  sudo curl -s -L $DC_BASH/docker-compose -o /etc/bash_completion.d/docker-compose
  echo "alias dc='docker-compose'" >> $HOME/.bash_aliases
  echo "complete -F _docker_compose dc" >> $HOME/.bash_aliases

  exit 0
}

function set_docker_engine {
  echo "INFO: Add bash completion for docker engine"
  sudo curl -s -L $DK_BASH/master/components/cli/contrib/completion/bash/docker -o /etc/bash_completion.d/docker.sh
  echo "alias dk='docker'" >> $HOME/.bash_aliases
  echo "complete -F _docker dk" >> $HOME/.bash_aliases
  echo "alias dk-ps='docker ps --format \"table {{.ID}}\t{{.Image}}\t{{.Status}}\"'" >> $HOME/.bash_aliases
  exit 0
}

function usage {
  echo $"Usage: $0 {engine|compose|machine}"
  echo ""
  echo "Install docker tooling."
}

case "$1" in
  vagrant)
    set_vagrant
    ;;
  engine)
    set_docker_engine
    ;;
  machine)
    set_docker_machine
    ;;
  compose)
    set_docker_compose
    ;;
  all)
    set_docker_engine
    set_docker_machine
    set_docker_compose
    ;;
  *)
    usage
    exit 1
esac
