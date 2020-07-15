#!/usr/bin/env bash

# Copyright 2020 chrislovecnm 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

git clone https://github.com/fatih/vim-go.git ~/.vim/pack/plugins/start/vim-go

git clone https://github.com/scrooloose/nerdtree.git ~/.vim/pack/dist/start/nerdtree
git clone https://github.com/vim-airline/vim-airline ~/.vim/pack/dist/start/vim-airline
git clone https://github.com/tpope/vim-fugitive.git ~/.vim/pack/dist/start/vim-fugitive
git clone https://github.com/ctrlpvim/ctrlp.vim ~/.vim/pack/dist/start/ctrlp.vom

git clone https://github.com/chrislovecnm/dotfiles.git ~/.dotfiles

git config --global user.name "chrislovecnm"
git config --global user.email clove@cnmconsulting.net
git config --global core.editor vim

git clone https://github.com/chrislovecnm/cockroach-operator ~/Workspace/src/github.com/cockroachdb/cockroach-operator

cd ~/Workspace/src/github.com/cockroachdb/cockroach-operator
git remote add upstream https://github.com/cockroachdb/cockroach-operator.git
cd ~/

gcloud init

# TODO
# init vim-go
echo "set backspace=indent,eol,start" >> ~/.vimrc
# vimrc for vim-go

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh --unattended)"
echo "source $HOME/.dotfiles/zshrc-include" >> $HOME/.zshrc
vim +'silent :GoInstallBinaries' +qal
sudo gpasswd -a $USER docker
sudo usermod --shell /bin/zsh $USER
