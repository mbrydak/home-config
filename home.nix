{ config, pkgs, inputs, ... }:

{
  nixpkgs.config.allowUnfreePredicate = (pkg: true);
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
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

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; }

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
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
  home.sessionVariables = { EDITOR = "nvim"; };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.autorandr = { enable = true; };

  # xsession.windowManager.i3 = {
  #   enable = false;
  #   config = {
  #     assigns = {
  #       "1: terminal" 
  #     };
  #   };
  # };

  # xsession.windowManager = {

  # xmonad = {
  #   enable = true;
  #   enableContribAndExtras = true;
  # };
  # awesome = {
  #   enable = true;
  #   luaModules = [
  #     pkgs.luaPackages.luarocks # is the package manager for lua modules
  #     pkgs.luaPackages.luadbi-mysql # database abstraction layer
  #     pkgs.luaPackages.vicious
  #   ];

  # };
  # };

  programs = {
    nushell = {
      enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      # configFile.source = ./.../config.nu;
      # for editing directly to config.nu 
      extraConfig = ''
        let carapace_completer = {|spans|
        carapace $spans.0 nushell $spans | from json
        }
        $env.config = {
         show_banner: false,
         completions: {
         case_sensitive: false # case-sensitive completions
         quick: true    # set to false to prevent auto-selecting completions
         partial: true    # set to false to prevent partial filling of the prompt
         algorithm: "fuzzy"    # prefix or fuzzy
         external: {
         # set to false to prevent nushell looking into $env.PATH to find more suggestions
             enable: true 
         # set to lower can improve completion performance at the cost of omitting some options
             max_results: 100 
             completer: $carapace_completer # check 'carapace_completer' 
           }
         }
        } 
        $env.PATH = ($env.PATH | 
        split row (char esep) |
        prepend /home/myuser/.apps |
        append /usr/bin/env
        )
      '';
      shellAliases = { };
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
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
      history = { ignoreDups = true; };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" "sudo" "aws" ];
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
      tmux = { enableShellIntegration = true; };
    };
    git = {
      enable = true;
      delta.enable = true;
      userEmail = "maxbrydak@gmail.com";
      userName = "mbrydak";
    };
    vscode = {
      enable = true;
      package = pkgs.vscode.fhs;
    };
    # vscode = {
    #   enable = true;
    #   enableExtensionUpdateCheck = false;
    #   enableUpdateCheck = false;
    #   extensions = (with pkgs.vscode-extensions; [
    #     golang.go
    #     asdine.cue
    #     mkhl.direnv 
    #     tsandall.opa 
    #     hashicorp.terraform
    #     christian-kohler.path-intellisense
    #     # redhat.ansible
    #     bbenoist.nix
    #     ms-kubernetes-tools.vscode-kubernetes-tools
    #     oderwat.indent-rainbow
    #   ]);
    # };
    # nixvim = {
    #   enable = true;
    #   enableMan = true;
    #   colorschemes.catppuccin.enable = true;
    #   clipboard = {
    #     register = "unnamedplus";
    #     providers.xclip.enable = true;
    #   };
    #   globals = { mapleader = " "; };
    #   keymaps = [
    #     {
    #       key = ";";
    #       action = ":";
    #     }
    #     {
    #       key = "<leader>v";
    #       action = "<cmd>CHADopen<cr>";
    #       mode = "n";
    #     }
    #   ];
    #   options = {
    #     number = true;
    #     relativenumber = true;
    #     shiftwidth = 2;
    #   };
    #   plugins = {
    #     auto-save = { enable = true; };
    #     surround = { enable = true; };
    #     chadtree = { enable = true; };
    #     lint = { enable = true; };
    #     which-key = { enable = true; };
    #     luasnip = { enable = true; };
    #     lightline = {
    #       enable = true;
    #       colorscheme = "rosepine";
    #     };
    #     copilot-lua.enable = true;
    #     nix.enable = true;
    #     nvim-autopairs.enable = true;
    #     telescope = {
    #       enable = true;
    #       keymaps = {
    #         "<C-p>" = {
    #           action = "git_files";
    #           desc = "Telescope Git Files";
    #         };
    #         "<leader>fg" = "live_grep";
    #       };
    #     };
    #     fugitive.enable = true;
    #     harpoon = {
    #       enable = true;
    #       enableTelescope = true;
    #       keymaps = {
    #         addFile = "<leader>ha";
    #         toggleQuickMenu = "<leader>g";
    #       };
    #     };
    #     treesitter.enable = true;
    #     treesitter-context.enable = true;
    #     cmp-nvim-lsp.enable = true;
    #     cmp = {
    #       enable = true;
    #       settings = {
    #         mapping = {
    #           "<CR>" = "cmp.mapping.confirm({ select = true })";
    #           "<Tab>" = {
    #             modes = [ "i" "s" ];
    #             action = ''
    #               function(fallback)
    #                 if cmp.visible() then
    #                   cmp.select_next_item()
    #                 elseif luasnip.expandable() then
    #                   luasnip.expand()
    #                 elseif luasnip.expand_or_jumpable() then
    #                   luasnip.expand_or_jump()
    #                 elseif check_backspace() then
    #                   fallback()
    #                 else
    #                   fallback()
    #                 end
    #               end
    #             '';
    #           };
    #           "<S-Tab>" = {
    #             modes = [ "i" "s" ];
    #             action = ''
    #               function(fallback)
    #                 if cmp.visible() then
    #                   cmp.select_prev_item()
    #                 elseif luasnip.expandable() then
    #                   luasnip.expand()
    #                 elseif luasnip.expand_or_jumpable() then
    #                   luasnip.expand_or_jump()
    #                 elseif check_backspace() then
    #                   fallback()
    #                 else
    #                   fallback()
    #                 end
    #               end
    #             '';
    #           };
    #         };
    #       };
    #     };
    #     lsp = {
    #       enable = true;
    #       keymaps = {
    #         diagnostic = {
    #           "<leader>j" = "goto_next";
    #           "<leader>k" = "goto_prev";
    #         };
    #         lspBuf = {
    #           K = "hover";
    #           gD = "references";
    #           gd = "definition";
    #           gi = "implementation";
    #           gt = "type_definition";
    #         };
    #       };
    #       servers = {
    #         bashls.enable = true;
    #         gopls.enable = true;
    #         terraformls.enable = true;
    #         jsonls.enable = true;
    #         nil_ls.enable = true;
    #         rust-analyzer.enable = true;
    #         html.enable = true;
    #         pyright.enable = true;
    #         tsserver.enable = true;
    #       };
    #     };
    #     tmux-navigator = { enable = true; };
    #   };
    # };

    tmux = {
      enable = true;
      terminal = "alacritty";
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
  };
}
