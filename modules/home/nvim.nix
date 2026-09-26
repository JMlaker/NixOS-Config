{ lib, config, pkgs, ... }:
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
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          vim.lsp.config('*', {
            capabilities = require('cmp_nvim_lsp').default_capabilities(),
          })

          vim.lsp.config('lua_ls', {
            settings = {
              Lua = {
                diagnostics = { globals = { "vim" } },
              },
            },
          })

          vim.lsp.enable({ "nixd", "lua_ls", "pyright", "bashls" })

          vim.diagnostic.config({
            virtual_text = true,
            underline = true,
            signs = true,
            severity_sort = true,
            update_in_insert = false,
          })

          vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
              local map = vim.keymap.set
              local opts = { buffer = ev.buf }

              map("n", "gd", vim.lsp.buf.definition, opts)
              map("n", "gD", vim.lsp.buf.declaration, opts)
              map("n", "gi", vim.lsp.buf.implementation, opts)
              map("n", "gr", vim.lsp.buf.references, opts)
              map("n", "K", vim.lsp.buf.hover, opts)
              map("n", "<leader>rn", vim.lsp.buf.rename, opts)
              map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
              map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)
              map("n", "[d", vim.diagnostic.goto_prev, opts)
              map("n", "]d", vim.diagnostic.goto_next, opts)
            end,
          })
        '';
      }
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          local cmp = require("cmp")

          cmp.setup({
            snippet = {
              expand = function(args)
                vim.snippet.expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ["<C-b>"] = cmp.mapping.scroll_docs(-4),
              ["<C-f>"] = cmp.mapping.scroll_docs(4),
              ["<C-Space>"] = cmp.mapping.complete(),
              ["<C-e>"] = cmp.mapping.abort(),
              ["<CR>"] = cmp.mapping.confirm({ select = true }),
              ["<Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                else
                  fallback()
                end
              end, { "i", "s" }),
              ["<S-Tab>"] = cmp.mapping(function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                else
                  fallback()
                end
              end, { "i", "s" }),
            }),
            sources = cmp.config.sources({
              { name = "nvim_lsp" },
              { name = "path" },
            }, {
              { name = "buffer" },
            }),
          })

          cmp.setup.cmdline({ "/", "?" }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = { { name = "buffer" } },
          })

          cmp.setup.cmdline(":", {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
          })
        '';
      }

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
            picker = { 
              enabled = true,
              sources = {
                explorer = {
                  layout = {
                    layout = { width = 32 }
                  },
                },
              },
            },
            quickfile = { enabled = true },
            scope = { enabled = true },
            scroll = { enabled = true },
            statuscolumn = { enabled = true },
            words = { enabled = true },
          })

          vim.keymap.set("n", "<leader>e", function()
            local explorers = Snacks.picker.get({ source = "explorer" })
            if #explorers > 0 then
              explorers[1]:focus()
            else
              Snacks.explorer()
            end
          end, { desc = "Focus explorer" })
        '';
      }
    ] ++ lib.optional config.programs.claude-code.enable 
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
      };

    extraPackages = with pkgs; [
      tree-sitter
      trashy
      ghostscript
      tectonic
      mermaid-cli
      lazygit

      nixd
      lua-language-server
      pyright
      bash-language-server
    ];
  };
}
