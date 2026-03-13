#!/bin/bash
ln -s $(pwd)/dot.bash_aliases ~/.bash_aliases

mkdir -p "$HOME/.local/bin"

t=$(mktemp -d)
pushd "$t"
curl -Lq https://github.com/dandavison/delta/releases/download/0.18.2/delta-0.18.2-aarch64-unknown-linux-gnu.tar.gz | tar xzf - --strip-components=1
mv delta ~/.local/bin
popd
rm -rf "$t"

t=$(mktemp -d)
pushd "$t"
curl -Lq https://github.com/rtk-ai/rtk/releases/download/v0.29.0/rtk-aarch64-unknown-linux-gnu.tar.gz | tar xf
mv rtk ~/.local/bin
popd
rm -rf "$t"

sudo apt update
sudo apt install --yes bat ripgrep tig
ln -s /usr/bin/batcat ~/.local/bin/bat

# installed_plugins.json からホストのパスを抽出してリンク作成
if [ -f "$HOME/.claude/plugins/installed_plugins.json" ]; then
  host_path=$(grep -o '"/Users/[^"]*/.claude' "$HOME/.claude/plugins/installed_plugins.json" | head -1 | sed 's|/.claude||' | tr -d '"')
  if [ -n "$host_path" ] && [ ! -e "$host_path" ]; then
    sudo mkdir -p "$(dirname "$host_path")"
    sudo ln -sf "$HOME" "$host_path"
  fi
fi
