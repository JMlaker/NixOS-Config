{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;

    viAlias = true;
    vimAlias = true;

    extraConfig = ''
      set number
      set tabstop=2
      set shiftwidth=2
      set expandtab

      let mapleader = " "
      let maplocalleader = " "
    '';

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp

      plenary-nvim
      telescope-nvim
      nvim-treesitter

      (nvim-treesitter.withPlugins (parsers: with parsers; [
        nix
        lua
        python
        bash
        fish
        c
        cpp
        json
        yaml
        markdown
        javascript
        latex
        regex
        perl
        systemverilog
      ]))

      catppuccin-nvim

      {
        plugin = snacks-nvim;
        type = "lua";
        config = ''
          require("snacks").setup({
            bigfile = { enabled = true },
            dashboard = { 
              enabled = true,
              sections = {
                { section = "header" },
                { section = "keys", gap = 1, padding = 1 },
                { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
                { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
              }
            },
            explorer = { 
              enabled = true,
              replace_netrw = true,
              trash = true
            },
            image = { enabled = true },
            input = { enabled = true },
            lazygit = { enabled = true },
            notifier = { enabled = true },
            picker = { enabled = true },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
          })

          vim.keymap.set("n", "<leader>e", function() Snacks.explorer() end, { desc = "Toggle file explorer" })
        '';
      }
      {
        plugin = claudecode-nvim;
        type = "lua";
        config = ''
          require("claudecode").setup({
            terminal = { provider = "snacks" },
          })

          local map = vim.keymap.set

          map("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude" })
          map("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
          map("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude" })
          map("n", "<leader>aC", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude" })
          map("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Select Claude model" })
          map("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add current buffer" })
          map("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send selection to Claude" })
          map("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept diff" })
          map("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny diff" })
        '';
      }
    ];

    extraPackages = with pkgs; [
      tree-sitter
      trashy
      ghostscript
      tectonic
      mermaid-cli
      lazygit
    ]; 
  };
}
