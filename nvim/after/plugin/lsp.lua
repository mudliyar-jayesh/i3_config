-- lsp-zero setup
local lsp_zero = require('lsp-zero')
local cmp = require('cmp')

-- Setup completion with nvim-cmp
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = {
    ['<C-y>'] = cmp.mapping.confirm({select = false}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    ['<C-p>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item({behavior = 'insert'})
      else
        cmp.complete()
      end
    end),
    ['<C-n>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item({behavior = 'insert'})
      else
        cmp.complete()
      end
    end),
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

-- LSP attach function for key mappings
local lsp_attach = function(client, bufnr)
  local opts = {buffer = bufnr}

  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)

  -- If formatting is supported, set format on save
  if client.server_capabilities.documentFormattingProvider then
    vim.cmd [[
      augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false })
      augroup END
    ]]
  end
end

-- Configure LSP-zero with custom attach
lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

-- LSP configuration for different languages
local lspConfig = require('lspconfig')

-- TypeScript setup with ts_ls (replacing tsserver)
lspConfig.ts_ls.setup{
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_dir = lspConfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
  on_attach = function(client, bufnr)
    -- Disable formatting, as we'll use null-ls/Prettier
    client.server_capabilities.documentFormattingProvider = false
    lsp_attach(client, bufnr)
  end
}

-- Omnisharp for C#
lspConfig.omnisharp.setup{
  cmd = { "/home/jayesh/.dotnet/dotnet", "/home/jayesh/.local/share/omnisharp/OmniSharp.dll" },
  root_dir = lspConfig.util.root_pattern('.git', '*.csproj', '*.sln'),
  settings = {
    FormattingOptions = {
      EnableEditorConfigSupport = true,
    },
    Sdk = {
      IncludePrereleases = true,
    },
  }
}

-- Rust Analyzer setup
lspConfig.rust_analyzer.setup{
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_dir = lspConfig.util.root_pattern("Cargo.toml", "rust-project.json"),
  settings = {
    ['rust-analyzer'] = {
      diagnostics = {
        enable = false
      }
    }
  }
}

-- clangd for C/C++
lspConfig.clangd.setup{
  cmd = {"clangd"},
  filetypes = {"c", "cpp", "objc", "objcpp", "cuda", "proto"},
  root_dir = lspConfig.util.root_pattern('.clangd', '.clang-tidy', '.clang-format', 'compile_commands.json', '.git'),
}

-- Go setup with gopls
lspConfig.gopls.setup {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_dir = lspConfig.util.root_pattern("go.work", "go.mod", ".git"),
}

-- Python setup with pyright
lspConfig.pyright.setup{
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
}

-- null-ls setup for formatting with Prettier
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,  -- Prettier for JavaScript, TypeScript, etc.
  },
  on_attach = function(client, bufnr)
    if client.supports_method('textDocument/formatting') then
      vim.cmd [[
        augroup FormatOnSave
          autocmd! * <buffer>
          autocmd BufWritePre <buffer> lua vim.lsp.buf.format({ async = false })
        augroup END
      ]]
    end
  end,
})

