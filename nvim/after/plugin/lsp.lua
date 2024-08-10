local lsp_zero = require('lsp-zero')

local cmp = require('cmp')

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
-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file
local lsp_attach = function(client, bufnr)
  local opts = {buffer = bufnr}

  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
end


lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

local lspConfig = require("lspconfig")
lspConfig.omnisharp.setup{
    cmd = { "/home/jayesh/.dotnet/dotnet", "/home/jayesh/.local/share/omnisharp/OmniSharp.dll" },
    root_dir = lspConfig.util.root_pattern('.git', '*.csproj', '*.sln'),
    settings = {
      FormattingOptions = {
        EnableEditorConfigSupport = true,
        OrganizeImports = nil,
      },
      MsBuild = {
        LoadProjectsOnDemand = nil,
      },
      RoslynExtensionsOptions = {
        EnableAnalyzersSupport = nil,
        EnableImportCompletion = nil,
        AnalyzeOpenDocumentsOnly = nil,
      },
      Sdk = {
        IncludePrereleases = true,
      },
    },
}

lspConfig.tsserver.setup{
    cmd = { "typescript-language-server", "--stdio"},
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
    root_dir = lspConfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git")
}

lspConfig.rust_analyzer.setup{
    cmd = { "rust-analyzer"},
    filetypes = { "rust" },
    root_dir = lspConfig.util.root_pattern("Cargo.toml", "rust-project.json"),
    single_file_support = true,
    settings = {
        ['rust-analyzer'] = {
            diagnostics = {
                enable = false;
            }
        }
    }
}


lspConfig.clangd.setup{
    cmd = {"clangd"},
    filetypes = {"c", "cpp", "objc", "objcpp", "cuda", "proto"},
    root_dir = lspConfig.util.root_pattern(
          '.clangd',
          '.clang-tidy',
          '.clang-format',
          'compile_commands.json',
          'compile_flags.txt',
          'configure.ac',
          '.git'
        ),
    single_file_support = true,
      

}
