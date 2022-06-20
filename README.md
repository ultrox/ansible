Radicaly fix Audio:
https://pipewire.org/

# ansible
Ansible setup for my box
export STOW_FOLDERS="bin,nvim,tmux,uwuntu,netflix,personal,i3,zsh,xkb"

More then likely this needs to be installed 

sudo pacman -S ansible sshpass openssh && \
sudo systemctl enable sshd && \
sudo systemctl start sshd

## Start

- After fresh install of manjaro first thing to do is
`sudo pacman -Syu` to update all packages (if you want to see the progress) that is since there is `pre_task` for that already running in playbook


## Status

### NPM
`npm list -g -depth1` global node packages
`npm outdated -g`
`npm update -g`

### Yay (aur)
`yay -Sua` update aur packages
`yay -Qm` list aur packages

## Pacman
`pacman -Qqet | grep -v "$(pacman -Qqg base)" | grep -v "$(pacman -Qqm)"` pacman package

 ## Works with dotfiles
 https://github.com/ultrox/dotfiles3
