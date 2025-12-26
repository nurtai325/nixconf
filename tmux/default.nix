{ pkgs, lib, ...}:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-b";
    terminal = "tmux-256color";
    plugins = [
      {
        plugin = pkgs.tmuxPlugins.catppuccin;
        extraConfig = ''
          set -g @plugin 'tmux-plugins/tpm'
          set -g @plugin 'tmux-plugins/tmux-sensible'
          set -g @plugin 'catppuccin/tmux'
          set -g @catppuccin_window_right_separator "█ "
          set -g @catppuccin_window_number_position "right"
          set -g @catppuccin_window_middle_separator " | "
          set -g @catppuccin_window_default_fill "none"
          set -g @catppuccin_window_current_fill "all"
          set -g @catppuccin_status_modules_right "session date_time"
          set -g @catppuccin_status_left_separator "█"
          set -g @catppuccin_status_right_separator "█"
          set -g @catppuccin_date_time_text "%Y-%m-%d %H:%M"
        '';
      }
    ];
    extraConfig = ''
      set -sg escape-time 0
      set-option -g status-position top

      unbind r
      unbind Tab
      bind r source-file ~/.config/tmux/tmux.conf

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      bind-key -n C-h select-window -t 0
      bind-key -n C-j select-window -t 1
      bind-key -n C-k select-window -t 2
      bind-key -n C-l select-window -t 3
    '';
  };
}
