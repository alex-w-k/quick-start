git clone https://github.com/morhetz/gruvbox.git ~/.vim/bundle/gruvbox
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
curl -fLo ~/.vimrc https://raw.githubusercontent.com/alex-w-k/quick-start/master/.vimrc
curl https://raw.githubusercontent.com/alex-w-k/quick-start/master/.bashrc >> ~/.bashrc
mkdir -p ~/.vim/undo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
git clone https://github.com/ogham/exa.git
cd exa
cargo build --release
sudo mv target/release/exa /usr/local/bin/
cd ~
source ~/.bashrc
