return function ()
  local cmp = require('cmp')
  local lspkind = require('lspkind')
  cmp.setup({
    completion = {
      completeopt = 'menu,menuone,noinsert',
    },
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    mapping = {
      --[[ ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(), ]]
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      ['<Tab>'] = function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
        --[[ elseif luasnip.expand_or_jumpable() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '') ]]
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-p>', true, true, true), 'n')
        --[[ elseif luasnip.jumpable(-1) then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '') ]]
        else
          fallback()
        end
      end,
    },
    sources = {
      { name = 'nvim_lsp' },
      -- { name = 'cmp_tabnine' },
      { name = 'treesitter' },
      { name = 'vim-dadbod-completion' },
      { name = 'vsnip' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'look' },
    },
    formatting = {
      deprecated = true,
      format = function(entry, vim_item)
        --[[ vim_item.kind = lspkind.presets.default[vim_item.kind]
        return vim_item ]]
            -- fancy icons and a name of kind
        vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind

        -- set a name for each source
        vim_item.menu = ({
          buffer = "[Buffer]",
          nvim_lsp = "[LSP]",
          vsnip = "[VSnip]",
          path = "[Path]",
          cmp_tabnine = "[Tabnine]",
          look = "[Look]",
          treesitter = "[Treesitter]",
          nvim_lua = "[Lua]",
          latex_symbols = "[Latex]",
          ['vim-dadbod-completion'] = "[Dadbod]",
        })[entry.source.name]
        return vim_item
      end
    }
  })
  -- you need setup cmp first put this after cmp.setup()
  --[[ require("nvim-autopairs.completion.cmp").setup({
    map_cr = true, --  map <CR> on insert mode
    map_complete = true, -- it will auto insert `(` after select function or method item
    auto_select = true -- automatically select the first item
  }) ]]
end
