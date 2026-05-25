{ ... }:
# mäßig wie .bashrc .. wechsel bald auf zsh vielleicht mal schauen so lange soll des hier sein
{
  programs.bash = {
    enable = true;
    initExtra = ''
      if command -v fnm >/dev/null 2>&1; then
        eval "$(fnm env --shell bash)"
      fi

      pythondevelop() {
        local version="${1:-3.12}"
        if ! command -v uv >/dev/null 2>&1; then
          echo "uv is not installed." >&2
          return 1
        fi

        uv python install "$version" || return $?
        uv venv --python "$version" || return $?
        if [ -f .venv/bin/activate ]; then
          source .venv/bin/activate
        else
          echo "No .venv created in $(pwd)." >&2
          return 1
        fi
      }
    '';
  };
}
