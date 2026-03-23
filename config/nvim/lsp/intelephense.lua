local get_intelephense_license = function()
  local f = assert(io.open(os.getenv 'HOME' .. '/intelephense/license.txt', 'rb'))
  local content = f:read '*a'
  f:close()
  return string.gsub(content, '%s+', '')
end

return {
  cmd = { 'intelephense', '--stdio' },
  filetypes = { 'php', 'blade' },
  root_markers = { 'composer.json', '.git' },
  init_options = {
    licenceKey = get_intelephense_license(),
  },
  settings = {
    intelephense = {
      files = {
        exclude = {
          '**/.git/**',
          '**/node_modules/**',
          '**/vendor/**/{Tests,test,tests}/**',
          '**/storage/framework/views/**',
          '**/storage/logs/**',
          '**/_ide_helper.php',
          '**/_ide_helper_models.php',
          '**/.phpstorm.meta.php',
        },
      },
    },
  },
}
