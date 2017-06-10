# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles # dotfiles directory
olddir=~/dotfiles_old # old dotfiles backup directory
files="bashrc vimrc vim gitignore tmux.conf" # list of files/folders to symlink in homedir

##########

# Install kupfer
sudo apt install kupfer

# Install tmux
sudo apt install tmux

# Installing Neovim and prerequisites
sudo apt install software-properties-common python-software-properties python-dev python-pip python3-dev python3-pip
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim


# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# Update git submodules to get vim-plugins working
echo "Initializing git submodules for vim-plugins"
git submodule init
echo "Updating git submodules for vim-plugins"
git submodule update

# Make neovim reference the vim directories
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

# Install jedi and python support for neovim
sudo pip install jedi neovim
sudo pip3 install jedi neovim
