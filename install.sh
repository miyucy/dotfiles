#!/bin/bash
ln -s $(pwd)/dot.bash_aliases ~/.bash_aliases

# installed_plugins.json からホストのパスを抽出してリンク作成
if [ -f "$HOME/.claude/plugins/installed_plugins.json" ]; then
  host_path=$(grep -o '"/Users/[^"]*/.claude' "$HOME/.claude/plugins/installed_plugins.json" | head -1 | sed 's|/.claude||' | tr -d '"')
  if [ -n "$host_path" ] && [ ! -e "$host_path" ]; then
    sudo mkdir -p "$(dirname "$host_path")"
    sudo ln -sf "$HOME" "$host_path"
  fi
fi

mkdir -p "$HOME/.local/bin"

sudo apt update
sudo apt install --yes bat ripgrep tig
ln -s /usr/bin/batcat ~/.local/bin/bat

t=$(mktemp -d)
pushd "$t"
curl -Lq https://github.com/dandavison/delta/releases/download/0.19.2/delta-0.19.2-aarch64-unknown-linux-gnu.tar.gz | tar xzf - --strip-components=1
mv delta ~/.local/bin
popd
rm -rf "$t"

t=$(mktemp -d)
pushd "$t"
curl -Lq https://github.com/rtk-ai/rtk/releases/download/v0.43.0/rtk-aarch64-unknown-linux-gnu.tar.gz | tar xzf -
mv rtk ~/.local/bin
popd
rm -rf "$t"
mkdir -p ~/.config/rtk
printf "[telemetry]\nenabled = false\n" >> ~/.config/rtk/config.toml

t=$(mktemp -d)
pushd "$t"
git clone --depth 1 --no-tags https://github.com/coderabbitai/git-worktree-runner.git
cd git-worktree-runner
./install.sh
popd
rm -rf "$t"

if [ -x uv ]; then
  uv tool install --upgrade 'cocoindex-code[full]'
fi
