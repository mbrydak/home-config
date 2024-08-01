{
  config,
  pkgs,
  inputs,
  ...
}:

{
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.keyboard = {
    options = [ "caps:escape" ];
  };
  home.username = "max";
  home.homeDirectory = "/home/max";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  home.sessionPath = [
    "$HOME/go/bin"
    "$HOME/.config/emacs/bin"
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    ansible
    arandr
    archi
    argocd
    autotiling
    bat
    bitwarden
    blueberry
    brightnessctl
    cloudflare-warp
    croc
    csview
    delve
    devbox
    dig
    direnv
    discord
    distrobox
    du-dust
    fd
    feh
    firefox
    fluxcd
    foliate
    freshfetch
    fzf
    gh
    git
    git-lfs
    glow
    gnumake
    go
    google-chrome
    gparted
    graphviz
    hddtemp
    htop
    ibm-plex
    inetutils
    jless
    jost
    jq
    k3d
    k9s
    killall
    kubectl
    kubernetes-helm
    libgen-cli
    llama-cpp
    lm_sensors
    (nerdfonts.override { fonts = [ "Hack" ]; })
    networkmanager
    networkmanager-openconnect
    nil
    nix-index
    obsidian
    okular
    openconnect
    openssl
    pavucontrol
    pcmanfm
    picom
    resumed
    ripgrep
    rsync
    scrot
    shutter
    slack
    spotify
    ssm-session-manager-plugin
    starship
    tealdeer
    thunderbird
    traceroute
    transmission_4
    tree
    unzip
    usbutils
    vlc
    xorg.xbacklight
    yq
    zap
    zathura
    zeal
    zip
    zotero
    zoxide
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/max/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    TERM = "xterm-256color";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.autorandr = {
    enable = true;
  };

  fonts = {
    fontconfig = {
      enable = true;
    };
  };

  programs = {
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      autocd = true;
      enableVteIntegration = true;
      shellAliases = {
        gitroot = "cd $(git rev-parse --show-toplevel)";
        v = "nvim";
        vim = "nvim";
        nv = "nvim";
        k = "kubectl --";
      };
      history = {
        ignoreDups = true;
      };
      oh-my-zsh = {
        enable = true;
        plugins = [
          "git"
          "sudo"
          "aws"
        ];
      };
      sessionVariables = {
        TERM = "xterm-256color";
      };
    };
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
    fzf = {
      enable = true;
      enableZshIntegration = true;
      changeDirWidgetCommand = "fd --type d . $HOME";
      fileWidgetCommand = "fd --type d .";
      tmux = {
        enableShellIntegration = true;
      };
    };
    git = {
      enable = true;
      delta.enable = true;
      userEmail = "maxbrydak@gmail.com";
      userName = "mbrydak";
    };
    nixvim = {
      enable = true;
      enableMan = true;
      colorschemes.catppuccin.enable = true;
      clipboard = {
        register = "unnamedplus";
        providers.xclip.enable = true;
      };
      globals = {
        mapleader = " ";
      };
      keymaps = [
        {
          key = ";";
          action = ":";
        }
        {
          key = "<leader>v";
          action = "<cmd>CHADopen<cr>";
          mode = "n";
        }
      ];
      opts = {
        number = true;
        relativenumber = true;
        shiftwidth = 2;
      };
      plugins = {
        auto-save = {
          enable = true;
        };
        surround = {
          enable = true;
        };
        chadtree = {
          enable = true;
        };
        lint = {
          enable = true;
        };
        which-key = {
          enable = true;
        };
        luasnip = {
          enable = true;
        };
        lightline = {
          enable = true;
          colorscheme = "rosepine";
        };
        copilot-lua.enable = true;
        nix.enable = true;
        nvim-autopairs.enable = true;
        telescope = {
          enable = true;
          # keymaps = {
          #   "<C-p>" = {
          #     action = "git_files";
          #     desc = "Telescope Git Files";
          #   };
          #   "<leader>fg" = "live_grep";
          # };
        };
        fugitive.enable = true;
        harpoon = {
          enable = true;
          enableTelescope = true;
          keymaps = {
            addFile = "<leader>ha";
            toggleQuickMenu = "<leader>g";
          };
        };
        treesitter.enable = true;
        treesitter-context.enable = true;
        cmp-nvim-lsp.enable = true;
        cmp = {
          enable = true;
          # settings = {
          #   mapping = {
          #     "<CR>" = "cmp.mapping.confirm({ select = true })";
          #     "<Tab>" = {
          #       modes = [ "i" "s" ];
          #       action = ''
          #         function(fallback)
          #           if cmp.visible() then
          #             cmp.select_next_item()
          #           elseif luasnip.expandable() then
          #             luasnip.expand()
          #           elseif luasnip.expand_or_jumpable() then
          #             luasnip.expand_or_jump()
          #           elseif check_backspace() then
          #             fallback()
          #           else
          #             fallback()
          #           end
          #         end
          #       '';
          #     };
          #     "<S-Tab>" = {
          #       modes = [ "i" "s" ];
          #       action = ''
          #         function(fallback)
          #           if cmp.visible() then
          #             cmp.select_prev_item()
          #           elseif luasnip.expandable() then
          #             luasnip.expand()
          #           elseif luasnip.expand_or_jumpable() then
          #             luasnip.expand_or_jump()
          #           elseif check_backspace() then
          #             fallback()
          #           else
          #             fallback()
          #           end
          #         end
          #       '';
          #     };
          #   };
          # };
        };
        lsp = {
          enable = true;
          keymaps = {
            diagnostic = {
              "<leader>j" = "goto_next";
              "<leader>k" = "goto_prev";
            };
            lspBuf = {
              K = "hover";
              gD = "references";
              gd = "definition";
              gi = "implementation";
              gt = "type_definition";
            };
          };
          servers = {
            bashls.enable = true;
            gopls.enable = true;
            terraformls.enable = true;
            jsonls.enable = true;
            nil-ls.enable = true;
            # rust-analyzer.enable = true;
            html.enable = true;
            pyright.enable = true;
            tsserver.enable = true;
          };
        };
        tmux-navigator = {
          enable = true;
        };
      };
    };

    alacritty = {
      enable = false;
      settings = {
        font = {
          normal = {
            family = "Hack Nerd Font Mono";
          };
        };
      };
    };
    tmux = {
      enable = true;
      terminal = "xterm-256color";
      clock24 = true;
      mouse = true;
      plugins = with pkgs; [
        {
          plugin = tmuxPlugins.resurrect;
          extraConfig = "set -g @resurrect-strategy-nvim 'session'";
        }
        {
          plugin = tmuxPlugins.continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-boot 'on'
            set -g @continuum-save-interval '1'
          '';
        }
        tmuxPlugins.vim-tmux-navigator
        tmuxPlugins.catppuccin
      ];
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    helix = {
      enable = true;
      defaultEditor = true;
      extraPackages = [
        pkgs.marksman
        pkgs.terraform-ls
        pkgs.nil
        pkgs.rust-analyzer
        pkgs.gopls
      ];
      languages = {
        language = [
          {
            name = "rust";
            auto-format = true;
          }
          {
            name = "hcl";
            auto-format = true;
          }
        ];
      };
    };
    rofi = {
      enable = true;
      terminal = "alacritty";
      extraConfig = {
        modes = "window,drun,run,ssh";
        show-icons = true;
      };
      theme = "gruvbox-dark-soft";
    };

  };
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      defaultWorkspace = "workspace number 3";
      bars = [
        {
          mode = "dock";
          hiddenState = "hide";
          workspaceButtons = true;
          workspaceNumbers = true;
          statusCommand = "${pkgs.i3status}/bin/i3status";
          trayOutput = "primary";
          colors = {
            background = "#000000";
            statusline = "#ffffff";
            separator = "#666666";
            focusedWorkspace = {
              border = "#4c7899";
              background = "#285577";
              text = "#ffffff";
            };
            activeWorkspace = {
              border = "#333333";
              background = "#5f676a";
              text = "#ffffff";
            };
            inactiveWorkspace = {
              border = "#333333";
              background = "#222222";
              text = "#888888";
            };
            urgentWorkspace = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
            bindingMode = {
              border = "#2f343a";
              background = "#900000";
              text = "#ffffff";
            };
          };

          fonts = {
            names = [ "Hack" ];
            size = 11.0;
          };

        }
      ];

      fonts = {
        names = [ "Hack" ];
        size = 11.0;
      };

      gaps = {
        smartGaps = true;
        bottom = 5;
        horizontal = 5;
        inner = 5;
        left = 5;
        outer = 5;
        right = 5;
        vertical = 5;
      };

      workspaceAutoBackAndForth = true;
      workspaceOutputAssign = [
        {
          output = "HDMI1";
          workspace = "3";
        }
        {
          output = "eDP1";
          workspace = "2";
        }
        {
          output = "DP-2";
          workspace = "1";
        }
      ];
      modifier = "Mod4";
      keybindings =
        let
          modifier = config.xsession.windowManager.i3.config.modifier;
        in
        pkgs.lib.mkOptionDefault {
          "${modifier}+Control+Left" = "focus output left";
          "${modifier}+Control+Right" = "focus output right";
          "${modifier}+Control+Shift+Left" = "move output left";
          "${modifier}+Control+Shift+Right" = "move output right";
          "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +10% && $refresh_i3status";
          "XF86AudioLowerVolume " = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -10% && $refresh_i3status";
          "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle && $refresh_i3status";
          "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute @DEFAULT_SOURCE@ toggle && $refresh_i3status";
          "XF86MonBrightnessUp" = "exec --no-stsartup-id brightnessctl set +10%";
          "XF86MonBrightnessDown" = "exec --no-stsartup-id brightnessctl set 10%-";
        };
      startup = [
        {
          command = "dex --autostart --environment i3";
          always = false;
          notification = false;
        }
        {
          command = "xss-lock --transfer-sleep-lock -- i3lock --nofork";
          always = false;
          notification = false;
        }
        {
          command = "nm-applet";
          always = false;
          notification = false;
        }
        {
          command = "i3wsr";
          always = true;
          notification = false;
        }
        {
          command = "i3altlayout";
          always = true;
          notification = false;
        }
      ];
      terminal = "alacritty";
    };
  };
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:escape" ];
    };
  };
}
