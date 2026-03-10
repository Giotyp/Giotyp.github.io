#!/bin/bash
set -e

echo "==> Setting up Jekyll development environment..."

# --- Homebrew ---
if ! command -v brew &>/dev/null; then
  echo "==> Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/homebrew/install/HEAD/install.sh)"
  # Add Homebrew to PATH for Apple Silicon / Intel
  if [[ -f /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -f /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
else
  echo "==> Homebrew already installed, skipping."
fi

# --- Ruby 3.1 ---
if ! brew list ruby@3.1 &>/dev/null; then
  echo "==> Installing Ruby 3.1..."
  brew install ruby@3.1
else
  echo "==> Ruby 3.1 already installed, skipping."
fi

# Detect Homebrew prefix (differs on Apple Silicon vs Intel)
BREW_PREFIX=$(brew --prefix)
RUBY_BIN="$BREW_PREFIX/opt/ruby@3.1/bin"
GEMS_BIN="$BREW_PREFIX/lib/ruby/gems/3.1.0/bin"

export PATH="$RUBY_BIN:$GEMS_BIN:$PATH"

# --- PATH in shell config ---
SHELL_RC="$HOME/.zshrc"
[[ "$SHELL" == *"bash"* ]] && SHELL_RC="$HOME/.bashrc"

if ! grep -q "ruby@3.1" "$SHELL_RC" 2>/dev/null; then
  echo "==> Adding Ruby 3.1 to PATH in $SHELL_RC..."
  echo "" >> "$SHELL_RC"
  echo "# Ruby 3.1 (for Jekyll)" >> "$SHELL_RC"
  echo "export PATH=\"$RUBY_BIN:\$PATH\"" >> "$SHELL_RC"
  echo "export PATH=\"$GEMS_BIN:\$PATH\"" >> "$SHELL_RC"
else
  echo "==> Ruby 3.1 already in $SHELL_RC, skipping."
fi

# --- Bundler ---
if ! gem list bundler -i --version 2.4.13 &>/dev/null; then
  echo "==> Installing Bundler 2.4.13..."
  gem install bundler:2.4.13
else
  echo "==> Bundler 2.4.13 already installed, skipping."
fi

# --- Project gems ---
echo "==> Installing project gems..."
bundle install

echo ""
echo "All done! To serve the site locally, run:"
echo "  bundle exec jekyll serve"
echo "Then open http://127.0.0.1:4000"
