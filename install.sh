#!/bin/bash
ln -s $(pwd)/dot.bash_aliases ~/.bash_aliases

mkdir -p "$HOME/.local/bin"

curl -LO https://github.com/dandavison/delta/releases/download/0.17.0/delta-0.17.0-aarch64-unknown-linux-gnu.tar.gz
tar xf delta-0.17.0-aarch64-unknown-linux-gnu.tar.gz
mv delta-0.17.0-aarch64-unknown-linux-gnu/delta "$HOME/.local/bin"
rm -rf delta-0.17.0-aarch64-unknown-linux-gnu.tar.gz delta-0.17.0-aarch64-unknown-linux-gnu
