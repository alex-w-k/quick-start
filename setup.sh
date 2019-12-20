git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
curl -fLo ~/.vimrc https://raw.githubusercontent.com/alex-w-k/quick-start/master/.vimrc
curl https://raw.githubusercontent.com/alex-w-k/quick-start/master/.bashrc >> ~/.bashrc
mkdir -p ~/.vim/undo
sudo yum install -y exa
