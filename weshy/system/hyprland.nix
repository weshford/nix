{ config, lib, osConfig, hyprbarsPluginPackage, ... }: # temporary as well 

lib.mkIf (osConfig.programs.hyprland.enable or false) {
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";
    plugins = [
      hyprbarsPluginPackage
    ];
    settings = {
      env = [
        "XCURSOR_SIZE,24"
        "XCURSOR_THEME,macOS"
        "XCURSOR_PATH,${config.home.homeDirectory}/.icons:${config.home.homeDirectory}/.local/share/icons:/usr/share/icons"
        "GTK_USE_PORTAL,1"
        "NIXOS_OZONE_WL,1"
        "ELECTRON_OZONE_PLATFORM_HINT,auto"
      ];

      monitor = [
        "eDP-1,1920x1080@60.02,2200x840,1"
        "DVI-I-1,1920x1080@100,3160x-240,1"
        "DVI-I-2,1920x1080@100,1240x-240,1"
        " ,preferred,auto,1"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "0xff6e5194";
        "col.inactive_border" = "0xff3e3e3e";
        resize_on_border = true;
        allow_tearing = false;
        layout = "dwindle";
      };

      input = {
        kb_layout = "de,us";
        kb_variant = "";
        kb_model = "";
        kb_options = "grp:alt_shift_toggle";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0.0;
        touchpad = {
          natural_scroll = false;
        };
      };

      dwindle = {
        # pseudotile = true;
        preserve_split = true;
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      plugin = {
        hyprbars = {
          bar_height = 30;
          bar_title_enabled = true;
          bar_text_align = "center";
          bar_text_size = 11;
          bar_buttons_alignment = "right";
          bar_part_of_window = true;
          bar_precedence_over_border = true;
          bar_padding = 8;
          bar_button_padding = 6;
          bar_color = "0x88f5f5f7";
          "col.text" = "0xff1c1c1e";
          icon_on_hover = false;
          "hyprbars-button" = [
            "rgb(ff5f57),13,,hyprctl dispatch killactive,rgb(1c1c1e)"
            "rgb(febc2e),13,,hyprctl dispatch fullscreen 1,rgb(1c1c1e)"
            "rgb(28c840),13,,hyprctl dispatch togglefloating; hyprctl dispatch resizeactive exact 66% 66%,rgb(1c1c1e)"
          ];
          on_double_click = "hyprctl dispatch fullscreen 1";
        };
      };

      exec-once = [
        # ''sh -lc "external_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.name | test(\"^(eDP|LVDS)\") | not) | .name' | head -n1); if [ -n \"$external_monitor\" ]; then for workspace in 1 2 3 4 5 6 7 8 9 10; do hyprctl keyword workspace \"$workspace,monitor:$external_monitor\"; done; fi"''
        "sh -lc \"external_monitor=\$(hyprctl monitors -j | jq -r '.[] | select(.name | test(\\\"^(eDP|LVDS|DSI)\\\") | not) | .name' | head -n1); lid_state_file=\$(find /proc/acpi/button/lid -name state -print -quit 2>/dev/null); if [ -n \\\"\$external_monitor\\\" ] && [ -n \\\"\$lid_state_file\\\" ] && grep -q closed \\\"\$lid_state_file\\\"; then hyprctl keyword monitor \\\"eDP-1,disable\\\"; fi\""
        "noctalia"
      ];

      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$ipc" = "noctalia msg";

      bind = [
        "$mod, T, exec, $terminal"
        "$mod, C, killactive,"
        "$mod SHIFT ALT, L, exit,"
        "$mod SHIFT, V, togglefloating,"
        "$mod, F, fullscreen,"

        # Workspace keybinds
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # noctlia shell things
        "$mod SHIFT, S, exec, $ipc screenshot-region" # TODO: Wait for screentoolkit
        "$mod SHIFT, H, exec, $ipc panel-toggle wallpaper"
        "$mod, V, exec, $ipc panel-toggle clipboard"
        "$mod, I, exec, $ipc settings-open"
        # "$mod, L, exec, $ipc lockScreen lock" # TODO : später machen wenn ich es testen kann
        # "$mod, R, exec, $ipc launcher command" # TODO: check if not needed anymore..
        "ALT, TAB, exec, $ipc window-switcher"
        ", XF86PowerOff, exec, $ipc sessionMenu toggle"

        # wichtig
        "$mod, E, exec, dolphin"
        # "$mod SHIFT, S, exec, $ipc plugin:screen-toolkit annotate"

        # Zoom
        # "binde = $mod, equal, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '.float * 1.1')"
        # "binde = $mod, minus, exec, hyprctl -q keyword cursor:zoom_factor $(hyprctl getoption cursor:zoom_factor -j | jq '(.float * 0.9) | if . < 1 then 1 else . end')"
      ];

      bindel = [
        # Volume controls
        ", XF86AudioRaiseVolume, exec, $ipc volume-up"
        ", XF86AudioLowerVolume, exec, $ipc volume-down"
        # Brightness controls
        ", XF86MonBrightnessUp, exec, $ipc brightness-up"
        ", XF86MonBrightnessDown, exec, $ipc brightness-down"
        # Media controls
        ", XF86AudioPlay, exec, $ipc media playPause"
        ", XF86AudioNext, exec, $ipc media next"
        ", XF86AudioPrev, exec, $ipc media previous"
      ];

      bindl = [
        ", switch:on:Lid Switch, exec, sh -lc \"external_monitor=\$(hyprctl monitors -j | jq -r '.[] | select(.name | test(\\\"^(eDP|LVDS|DSI)\\\") | not) | .name' | head -n1); if [ -n \\\"\$external_monitor\\\" ]; then hyprctl keyword monitor \\\"eDP-1,disable\\\"; fi\""
        ", switch:off:Lid Switch, exec, sh -lc \"external_monitor=\$(hyprctl monitors -j | jq -r '.[] | select(.name | test(\\\"^(eDP|LVDS|DSI)\\\") | not) | .name' | head -n1); if [ -n \\\"\$external_monitor\\\" ]; then hyprctl keyword monitor \\\"eDP-1,1920x1080@60.02,2200x840,1\\\"; fi\""
        # TODO: Abwarten ...
        # ", switch:on:Lid Switch, exec, $ipc dpms-on"
        # ", switch:off:Lid Switch, exec, $ipc dpms-off"
      ];

      # bindl = [
      #   # Mute controls (no repeat)
      #   ", XF86AudioMute, exec, $ipc volume muteOutput"
      #   ", XF86AudioMicMute, exec, $ipc volume muteInput"
      # ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindr = [
        "$mod, SUPER_L, exec, $ipc panel-toggle launcher"
      ];
    };
  };
}
