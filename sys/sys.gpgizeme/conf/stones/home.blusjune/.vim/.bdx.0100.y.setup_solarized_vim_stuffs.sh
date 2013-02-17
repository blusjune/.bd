(cd bundle;

if [ -d vim-colors-solarized ]; then
        echo "WARNING >>> vim-colors-solarized directory exists";
fi
if [ -d vim-fugitive ]; then
        echo "WARNING >>> vim-fugitive directory exists";
fi

git clone git://github.com/altercation/vim-colors-solarized.git
git clone git://github.com/tpope/vim-fugitive.git
)
