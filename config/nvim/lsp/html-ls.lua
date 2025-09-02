return {
  cmd = { 'vscode-html-language-server', '--stdio' },
  filetypes = {
    'html',
    'blade',
    'javascriptreact',
    'typescriptreact',
    'svelte',
  },
  root_markers = { 'package.json', 'index.html', '.git' },
  settings = {},
  init_options = {
    provideFormatter = true,
    embeddedLanguages = { css = true, javascript = true },
    configurationSection = { 'html', 'css', 'javascript' },
  },
}
