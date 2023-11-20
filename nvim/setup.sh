set -e
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
     ~/.local/share/nvim/site/pack/packer/start/packer.nvim
mkdir -p ~/.config/nvim/lua/kdc/
mkdir -p ~/.config/nvim/after/plugin/
cp -v ./lua/kdc/* ~/.config/nvim/lua/kdc/
cp -v ./after/plugin/* ~/.config/nvim/after/plugin/
cp -v ./init.lua ~/.config/nvim/
