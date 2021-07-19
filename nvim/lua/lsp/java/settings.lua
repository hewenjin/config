local M = {}
local root_markers = {'gradlew', 'pom.xml'}
local root_dir = require('jdtls.setup').find_root(root_markers)
local home = os.getenv('HOME')
--[[ local workspace_name, _ = string.gsub(vim.fn.fnamemodify(new_root_dir, ":p"),
                                      "/", "-") ]]
--[[ local workspace_folder =
    home .. "/.local/share/nvim/lspinstall/java/workspace/" ..
        vim.fn.fnamemodify(root_dir, ":p:h:t") ]]
local workspace_name, _ = string.gsub(vim.fn.fnamemodify(root_dir, ":p"), "/", "-")
M.cmd = {home .. '/.local/share/nvim/lspinstall/java/jdtls.sh', home .. "/.local/share/nvim/lspinstall/java/workspace/" .. workspace_name}
M.capabilities = {
  workspace = {configuration = true},
  textDocument = {completion = {completionItem = {snippetSupport = true}}}
}
--[[ local jar_patterns = {
  home ..
      '/.config/nvim/lua/lsp/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar',
  -- '/dev/dgileadi/vscode-java-decompiler/server/*.jar',
  home .. '/.config/nvim/lua/lsp/java/vscode-java-test/server/*.jar'
} ]]

--[[ for _, jar_pattern in ipairs(jar_patterns) do
  for _, bundle in ipairs(vim.split(vim.fn.glob(home .. jar_pattern), '\n')) do
    if not vim.endswith(bundle, 'com.microsoft.java.test.runner.jar') then
      table.insert(bundles, bundle)
    end
  end
end ]]

local bundles = {
  vim.fn.glob(home ..
                  '/.config/nvim/lua/lsp/java/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar')
}
vim.list_extend(bundles, vim.split(vim.fn.glob(home ..
                                                   '/.config/nvim/lua/lsp/java/vscode-java-test/server/*.jar'),
                                   '\n'))
-- local extendedClientCapabilities = {}
local extendedClientCapabilities = require'jdtls'.extendedClientCapabilities
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
M.init_options = {
  bundles = bundles,
  extendedClientCapabilities = extendedClientCapabilities
}

M.settings = {
  ['java.format.settings.url'] = home .. "/project/java-google-formatter.xml",
  ['java.format.settings.profile'] = "GoogleStyle",
  java = {
    signatureHelp = {enabled = true},
    contentProvider = {preferred = 'fernflower'},
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat", "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*", "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse", "org.mockito.Mockito.*"
      }
    },
    sources = {
      organizeImports = {starThreshold = 9999, staticStarThreshold = 9999}
    },
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
      }
    },
    home = "/usr/lib/jvm/java-8-openjdk/",
    configuration = {
      runtimes = {
        {name = "JavaSE-11", path = "/usr/lib/jvm/java-11-openjdk/"},
        {
          name = "JavaSE-1.8",
          path = "/usr/lib/jvm/java-8-openjdk/",
          default = true
        }
        --[[ {
            name = "JavaSE-14",
            path = home .. "/usr/lib/jvm/java-11-openjdk/",
          }, ]]
      }
    }
  }
}

M.on_init = function(client, _)
  client.notify('workspace/didChangeConfiguration', {settings = M.settings})
end

return M
