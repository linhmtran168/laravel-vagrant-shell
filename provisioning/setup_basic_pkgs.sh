#!/bin/sh

echo ">>> Start install basic packages"

sudo apt-get update

# Install some base package
sudo apt-get install -qq tmux git build-essential python-software-properties zsh autojump

home_dir=/home/vagrant
zprezto_dir=$home_dir/.zprezto
if [ ! -d $zprezto_dir ]; then
  # Install zpresto
  git clone --recursive https://github.com/sorin-ionescu/prezto.git $zprezto_dir
  # Change default shell to zsh for vagrant user
  sudo chsh -s /bin/zsh vagrant
fi


# Install dotfiles for linux
dotfiles_dir=/home/vagrant/dotfiles
if [ ! -d $dotfiles_dir ]; then
  git clone git@github.com:linhmtran168/linux_dotfiles.git $dotfiles_dir

  # Link setting file
  ln -sf $dotfiles_dir/.zpreztorc $home_dir
  ln -sf $dotfiles_dir/.zprofile $home_dir
  ln -sf $dotfiles_dir/.zshrc $home_dir
  ln -sf $dotfiles_dir/.tmux.conf $home_dir

  # Link zprezto theme
  ln -sf $dotfiles_dir/prompt_superlinh_setup $zprezto_dir/modules/prompt/functions/
fi

echo ">>> End install basic packages"
