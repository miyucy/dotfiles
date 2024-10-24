#!/bin/bash
ln -s $(pwd)/dot.bash_aliases ~/.bash_aliases

mkdir -p "$HOME/.local/bin"

t=$(mktemp -d)
pushd "$t"
curl -Lq https://github.com/dandavison/delta/releases/download/0.18.2/delta-0.18.2-aarch64-unknown-linux-gnu.tar.gz | tar xzf - --strip-components=1
mv delta ~/.local/bin
popd
rm -rf "$t"

sudo apt update
sudo apt install --yes bat ripgrep
ln -s /usr/bin/batcat ~/.local/bin/bat
