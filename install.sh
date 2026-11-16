#!/data/data/com.termux/files/usr/bin/bash
# ============================================================
#  TERMUX BASH THEME CUSTOMIZER — ALL-IN-ONE INSTALLER
#  One file: creates project, installs, themes, uninstaller.
#  Usage:  bash termux-bash-theme-installer.sh
# ============================================================
set -u
trap 'echo "ERROR: failed at line $LINENO" >&2; exit 1' ERR

SRC="$HOME/termux-bash-theme"
TH_DIR="$HOME/.termux-bash-theme"
BASHRC="$HOME/.bashrc"
MARKER="# >>> termux-bash-theme (managed block) >>>"
MARKER_END="# <<< termux-bash-theme <<<"

echo "==> Termux Bash Theme Customizer (all-in-one)"

# ---------- 1. Environment detection ----------
if [ "$(uname -o 2>/dev/null)" != "Android" ] && [ ! -d "/data/data/com.termux/files/usr" ]; then
  echo "WARNING: Termux not detected; continuing best-effort." >&2
fi
PREFIX="/data/data/com.termux/files/usr"
[ -d "$PREFIX" ] && PATH="$PREFIX/bin:$PATH"

# ---------- 2. Dependency check ----------
for cmd in bash git; do
  command -v "$cmd" >/dev/null 2>&1 || { echo "Missing: $cmd — run: pkg install bash git"; exit 1; }
done

# ---------- 3. Build project source tree ----------
mkdir -p "$SRC"/{themes,banners,config,scripts}

# ===== THEMES =====
cat > "$SRC/themes/theme-hacker-red.sh" <<'EOF'
export TH_THEME_NAME="Hacker Red"
export TH_PS1='\[\e[1;31m\]\u\[\e[0;37m\]@\[\e[1;31m\]\h\[\e[0m\]:\[\e[1;37m\]\w\[\e[1;31m\]$(__th_git_branch)\[\e[0m\]\$ '
export TH_COLORS="\e[1;31m"
EOF

cat > "$SRC/themes/theme-matrix-green.sh" <<'EOF'
export TH_THEME_NAME="Matrix Green"
export TH_PS1='\[\e[1;32m\]\u\[\e[0;32m\]@\[\e[1;32m\]\h\[\e[0m\]:\[\e[0;32m\]\w\[\e[1;32m\]$(__th_git_branch)\[\e[0m\]\$ '
export TH_COLORS="\e[1;32m"
EOF

cat > "$SRC/themes/theme-cyber-blue.sh" <<'EOF'
export TH_THEME_NAME="Cyber Blue"
export TH_PS1='\[\e[1;36m\]\u\[\e[0;37m\]@\[\e[1;36m\]\h\[\e[0m\]:\[\e[1;34m\]\w\[\e[1;36m\]$(__th_git_branch)\[\e[0m\]\$ '
export TH_COLORS="\e[1;36m"
EOF

cat > "$SRC/themes/theme-jarvis.sh" <<'EOF'
export TH_THEME_NAME="Jarvis"
export TH_PS1='\[\e[1;94m\][\[\e[1;97m\]\u@\h\[\e[0;96m\]|\[\e[1;94m\]\w\[\e[1;94m\]$(__th_git_branch)\[\e[1;94m\]]\[\e[0m\]\$ '
export TH_COLORS="\e[1;94m"
EOF

cat > "$SRC/themes/theme-neon-purple.sh" <<'EOF'
export TH_THEME_NAME="Neon Purple"
export TH_PS1='\[\e[1;35m\]\u\[\e[0;95m\]@\[\e[1;35m\]\h\[\e[0m\]:\[\e[0;95m\]\w\[\e[1;35m\]$(__th_git_branch)\[\e[0m\]\$ '
export TH_COLORS="\e[1;35m"
EOF

cat > "$SRC/themes/theme-minimal.sh" <<'EOF'
export TH_THEME_NAME="Minimal"
export TH_PS1='\[\e[0m\]\u@\h:\w$(__th_git_branch)\$ '
export TH_COLORS="\e[0m"
EOF

# ===== BANNERS =====
cat > "$SRC/banners/banner-hacker-red.txt" <<'EOF'
   ____   ____ ______ ____
  / __ \ / __ // ____// __ \
 / /_/ // /_/ /\ \   / /_/ /
/ ____// ____/ \ \  / ____/
/_/   /_/       \_\/_/
EOF

cat > "$SRC/banners/banner-matrix-green.txt" <<'EOF'
 __  __  ___  _   _    _    _   _  ____ ___  _   _
\ \/ / / _ \| \ | |  / \  | \ | |/ ___/ _ \| \ | |
 \  / | | | |  \| | / _ \ |  \| | |  | | | |  \| |
 /  \ | |_| | |\  |/ ___ \| |\  | |__| |_| | |\  |
/_/\_\ \___/|_| \_/_/   \_\_| \_|\____\___/|_| \_|
EOF

cat > "$SRC/banners/banner-cyber-blue.txt" <<'EOF'
  ____ ____  _  _  ____ _  _ ___  _    ____
 / ___|  _ \| \| |/ ___| \| / __|| |  / ___|
| |    |   /| \\  | |   |  _| \__ \| |_| |\  |
 \____|\_\_\|_|\_|\____.|_|  |_|/___/|___/|_| \_|
EOF

cat > "$SRC/banners/banner-jarvis.txt" <<'EOF'
     _        ___  ___  _   _
    / \      / _ \/ __|| \ | |
   / _ \    | | | \__ \|  \ |
  / ___ \   | |_| / __/| |\  |
 /_/   \_\   \___/\___/|_| \_|
     J.U.S.T. A RATHER VERY INTELLIGENT SHELL
EOF

cat > "$SRC/banners/banner-neon-purple.txt" <<'EOF'
 _   _  ___  _  _  ___  ___  _  _
| \ | ||_ _|| \| || __|| _ \| \| |
|  \| | | | | .  || _| |   /| .  |
|_|\__||___||_|\_||___||_\_\|_|\_|
EOF

echo "~ termux bash theme :: minimal ~" > "$SRC/banners/banner-minimal.txt"

# ===== CONFIG =====
cat > "$SRC/config/aliases.sh" <<'EOF'
alias ll='ls -la --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias ..='cd ..'
alias ...='cd ../..'
alias cls='clear'
alias update='pkg update -y && pkg upgrade -y'
alias install='pkg install -y'
alias myip='curl -s ifconfig.me && echo'
alias ports='ss -tuln'
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
EOF

cat > "$SRC/config/functions.sh" <<'EOF'
__th_git_branch() {
  command -v git >/dev/null 2>&1 || return
  local b
  b=$(git -C "$PWD" symbolic-ref --short HEAD 2>/dev/null) || return
  printf ' (%s)' "$b"
}
extract() {
  [ -f "$1" ] || { echo "extract: '$1' not found"; return 1; }
  case "$1" in
    *.tar.gz|*.tgz) tar xzf "$1" ;;
    *.tar.bz2)      tar xjf "$1" ;;
    *.tar.xz)       tar xJf "$1" ;;
    *.zip)          unzip "$1" ;;
    *.rar)          unrar x "$1" ;;
    *.7z)           7z x "$1" ;;
    *) echo "extract: unknown format"; return 1 ;;
  esac
}
bak() { cp "$1" "$1.bak.$(date +%Y%m%d_%H%M%S)" && echo "Backup: $1.bak.$(date +%Y%m%d_%H%M%S)"; }
mkcd() { mkdir -p "$1" && cd "$1" || return; }
weather() { curl -s "wttr.in/${1:-}"; }
EOF

cat > "$SRC/config/banner.sh" <<'EOF'
if [ -r "$HOME/.termux-bash-theme/.theme" ]; then
  . "$HOME/.termux-bash-theme/.theme" 2>/dev/null
  if [ "${TH_ANIMATION:-0}" = "1" ]; then
    _th_anim() {
      local i j c
      for i in $(seq 1 8); do
        c=""
        for j in $(seq 1 40); do
          case $((RANDOM % 4)) in 0) c="$c " ;; *) c="$c${TH_COLORS}${RANDOM:0:1}" ;; esac
        done
        printf '%b\n' "$c"; sleep 0.05
      done
    }
    _th_anim
  fi
  if [ -r "$HOME/.termux-bash-theme/banners/banner-${TH_THEME_ID}.txt" ]; then
    printf '%b\n' "${TH_COLORS}"
    cat "$HOME/.termux-bash-theme/banners/banner-${TH_THEME_ID}.txt"
    printf '\e[0m\n'
  fi
fi
EOF

# ===== SCRIPTS =====
cat > "$SRC/scripts/reset.sh" <<EOF
#!/data/data/com.termux/files/usr/bin/bash
TH_DIR="$TH_DIR"
[ -f "\$TH_DIR/backup/bashrc.original" ] || { echo "No backup found."; exit 1; }
cp "\$TH_DIR/backup/bashrc.original" "$BASHRC"
rm -f "\$TH_DIR/.theme"
echo "Original .bashrc restored. Restart Termux."
EOF

cat > "$SRC/scripts/theme-preview.sh" <<EOF
#!/data/data/com.termux/files/usr/bin/bash
. "$TH_DIR/lib.sh" 2>/dev/null
th_theme_preview "\${1:-}"
EOF

# ---------- 4. Install to runtime directory ----------
mkdir -p "$TH_DIR"/{themes,banners,config,scripts,backup}
cp -r "$SRC"/{themes,banners,config,scripts}/* "$TH_DIR/" 2>/dev/null

# Backup existing configuration (automatic, non-destructive)
if [ -f "$BASHRC" ]; then
  cp "$BASHRC" "$TH_DIR/backup/bashrc.original"
  echo "==> Backup: $TH_DIR/backup/bashrc.original"
else
  : > "$BASHRC"
  cp "$BASHRC" "$TH_DIR/backup/bashrc.original"
fi
cp "$HOME/.profile" "$TH_DIR/backup/profile.original" 2>/dev/null || true

# ---------- 5. lib.sh (core logic) ----------
cat > "$TH_DIR/lib.sh" <<'EOF'
TH_DIR="$HOME/.termux-bash-theme"
CONF="$TH_DIR/settings.conf"

th_get() { grep -E "^$1=" "$CONF" 2>/dev/null | cut -d= -f2-; }
th_set() { sed -i "s/^$1=.*/$1=$2/" "$CONF"; }

th_theme_preview() {
  local id="$1" f="$TH_DIR/themes/theme-$id.sh"
  [ -f "$f" ] || { echo "Theme not found: $id"; return 1; }
  echo "--- BANNER ---"
  [ -f "$TH_DIR/banners/banner-$id.txt" ] && cat "$TH_DIR/banners/banner-$id.txt"
  echo "--- PROMPT ---"
  printf 'Sample prompt (raw): %s\n' "$(grep TH_PS1 "$f" | cut -d"'" -f2 | sed 's/\\\[\|\\\]//g')"
  printf 'Color: %b sample-text \e[0m\n' "$(grep TH_COLORS "$f" | cut -d'"' -f2)"
}

th_install_theme() {
  local id="$1" f="$TH_DIR/themes/theme-$id.sh"
  [ -f "$f" ] || { echo "Theme not found: $id"; return 1; }
  printf 'TH_THEME_ID=%s\n' "$id" > "$TH_DIR/.theme"
  th_write_bashrc
  echo "Theme '$id' applied. Restart Termux or: source ~/.bashrc"
}

th_write_bashrc() {
  local BASHRC="$HOME/.bashrc" block
  block=$(cat <<BLK
$MARKER
[ -r "$TH_DIR/config/aliases.sh" ] && . "$TH_DIR/config/aliases.sh"
[ -r "$TH_DIR/config/functions.sh" ] && . "$TH_DIR/config/functions.sh"
[ -r "$TH_DIR/config/banner.sh" ] && . "$TH_DIR/config/banner.sh"
if [ -r "$TH_DIR/.theme" ]; then
  . "$TH_DIR/.theme"
  [ -r "$TH_DIR/themes/theme-\$TH_THEME_ID.sh" ] && . "$TH_DIR/themes/theme-\$TH_THEME_ID.sh"
  export PS1="\$TH_PS1"
fi
$MARKER_END
BLK
)
  sed -i "/^$MARKER\$/,/^$MARKER_END\$/d" "$BASHRC" 2>/dev/null
  printf '\n%s\n' "$block" >> "$BASHRC"
}
EOF

# ---------- 6. Settings + uninstaller ----------
[ -f "$TH_DIR/settings.conf" ] || printf 'animation=0\n' > "$TH_DIR/settings.conf"

cat > "$TH_DIR/uninstall-runner.sh" <<EOF
#!/data/data/com.termux/files/usr/bin/bash
[ -f "$TH_DIR/backup/bashrc.original" ] && cp "$TH_DIR/backup/bashrc.original" "$BASHRC"
[ -f "$BASHRC" ] && sed -i "/^$MARKER\$/,/^$MARKER_END\$/d" "$BASHRC"
rm -f "$PREFIX/bin/termux-theme"
rm -rf "$TH_DIR"
echo "termux-bash-theme removed. Restart Termux."
EOF

# ---------- 7. Interactive menu ----------
cat > "$TH_DIR/scripts/theme-menu.sh" <<EOF
#!/data/data/com.termux/files/usr/bin/bash
. "$TH_DIR/lib.sh" 2>/dev/null
while true; do
  clear
  printf '\e[1;36m╔══════════════════════════════════════╗\e[0m\n'
  printf '\e[1;36m║   TERMUX BASH THEME CUSTOMIZER       ║\e[0m\n'
  printf '\e[1;36m╚══════════════════════════════════════╝\e[0m\n'
  echo
  echo "  1) Hacker Red      4) Jarvis"
  echo "  2) Matrix Green    5) Neon Purple"
  echo "  3) Cyber Blue      6) Minimal"
  echo "  p) Preview a theme"
  echo "  a) Toggle animation (currently: \$( [ "\$(th_get animation)" = "1" ] && echo ON || echo OFF ))"
  echo "  r) Reset to original"
  echo "  u) Uninstall"
  echo "  q) Quit"
  echo
  printf 'Choose: '
  read -r c
  case "\$c" in
    1) th_theme_preview hacker-red && th_install_theme hacker-red ;;
    2) th_theme_preview matrix-green && th_install_theme matrix-green ;;
    3) th_theme_preview cyber-blue && th_install_theme cyber-blue ;;
    4) th_theme_preview jarvis && th_install_theme jarvis ;;
    5) th_theme_preview neon-purple && th_install_theme neon-purple ;;
    6) th_theme_preview minimal && th_install_theme minimal ;;
    p) echo "Ids: hacker-red matrix-green cyber-blue jarvis neon-purple minimal"
       printf 'Theme id: '; read -r t; th_theme_preview "\$t" ;;
    a) [ "\$(th_get animation)" = "1" ] && th_set animation 0 || th_set animation 1 ;;
    r) bash "$TH_DIR/scripts/reset.sh"; exit 0 ;;
    u) bash "$TH_DIR/uninstall-runner.sh"; exit 0 ;;
    q) exit 0 ;;
    *) echo "Invalid option." ;;
  esac
  printf 'Press Enter...'; read -r
done
EOF

# ---------- 8. Inject managed block into .bashrc ----------
bash -c ". '$TH_DIR/lib.sh' && th_write_bashrc"

# ---------- 9. Universal command ----------
cat > "$PREFIX/bin/termux-theme" <<EOF
#!/data/data/com.termux/files/usr/bin/bash
. "$TH_DIR/lib.sh"
case "\${1:-}" in
  "")        bash "$TH_DIR/scripts/theme-menu.sh" ;;
  list)      ls "$TH_DIR/themes" | sed 's/theme-//; s/\.sh$//' ;;
  preview)   th_theme_preview "\${2:-}" ;;
  install)   th_install_theme "\${2:-}" ;;
  reset)     bash "$TH_DIR/scripts/reset.sh" ;;
  uninstall) bash "$TH_DIR/uninstall-runner.sh" ;;
  help|*)    echo "termux-theme [list|preview <id>|install <id>|reset|uninstall|help]" ;;
esac
EOF
chmod +x "$PREFIX/bin/termux-theme" "$TH_DIR/scripts/"*.sh "$TH_DIR/uninstall-runner.sh"

echo "==> Done! Run: termux-theme"
