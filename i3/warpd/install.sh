dir="$HOME"/.aliases/i3/warpd/warpd-repo

git clone https://github.com/rvaiya/warpd.git "$dir"
cd "$dir" || echo "!! ERROR !! cd fails"

echo "installing dependencies . . ."
sudo apt install -y \
    libxi-dev \
    libxinerama-dev \
    libxft-dev \
    libxfixes-dev \
    libxtst-dev \
    libx11-dev \
    libcairo2-dev \
    libxkbcommon-dev \
    libwayland-dev && \
make && sudo make install && \
rm -rf "$dir"

