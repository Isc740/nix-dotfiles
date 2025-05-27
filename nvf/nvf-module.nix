{
  pkgs,
  lib,
  ...
}: {
  vim = {
    theme = {
      enable = true;
      name = "rose-pine";
      style = "main";
    };

    options = {
      shiftwidth = 2;
      tabstop = 2;
    };

    viAlias = true;
    vimAlias = true;

    # spellcheck = {
    #   enable = true;
    # };

    autocomplete.nvim-cmp = {
      enable = true;
      mappings = {
        confirm = "<C-y>";
      };
    };

    statusline.lualine.enable = true;
    telescope.enable = true;
    autopairs.nvim-autopairs.enable = true;
    snippets.luasnip.enable = true;
    git.vim-fugitive.enable = true;
    git.gitsigns.enable = true;
    diagnostics = {
      enable = true;
      virtual_text = true;
      nvim-lint.enable = true;
    };

    filetree = {
      neo-tree = {
        enable = true;
      };
    };

    binds = {
      whichKey.enable = true;
      cheatsheet.enable = true;
      # hardtime-nvim.enable = true;
    };

    utility = {
      yanky-nvim.enable = false;
      surround.enable = true;
    };

    notify = {
      nvim-notify.enable = true;
    };

    visuals = {
      indent-blankline.enable = true;
      nvim-web-devicons.enable = true;
      nvim-cursorline.enable = true;
      cinnamon-nvim.enable = true;
      fidget-nvim.enable = true;

      highlight-undo.enable = true;
    };

    ui = {
      colorizer.enable = true;
    };

    lsp = {
      enable = true;
      formatOnSave = true;
      lspkind.enable = true;
      lightbulb.enable = true;
      lspsaga.enable = true;
      trouble.enable = true;
      lspSignature.enable = true;
      otter-nvim.enable = true;
      nvim-docs-view.enable = true;
    };

    languages = {
      enableFormat = true;
      enableExtraDiagnostics = true;
      enableTreesitter = true;

      nix.enable = true;
      ts = {
        enable = true;
        lsp.server = "denols";
      };
      go.enable = true;
      tailwind.enable = true;
      sql.enable = true;
      html = {
        enable = true;
        treesitter.autotagHtml = true;
      };
      css.enable = true;
    };
  };
}
