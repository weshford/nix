{ ... }:
# mäßig wie .bashrc .. wechsel bald auf zsh vielleicht mal schauen so lange soll des hier sein
{
  programs.bash = {
    enable = true;
    initExtra = ''
      if command -v fnm >/dev/null 2>&1; then
        eval "$(fnm env --shell bash)"
      fi
    '';
  };
}
