local java = {}

local jdtls = require "jdtls"
local jdtls_setup = require "jdtls.setup"

local common = require "nacro.lsp.common"
local map = require "nacro.utils.map"

local fn = vim.fn

local nnoremap = map.nnoremap
local vnoremap = map.vnoremap

function java.setup()
  -- vim.cmd [[autocmd FileType java lua require('nacro.lsp.java').on_java_opened()]]
end

local function on_jdtls_attached(client, bufnr)
  common.on_attach(client, bufnr)

  ---Create a function that calls the function with true as its first parameter
  ---@param func function(param: bool)
  ---@return function()
  local function w_true(func)
    return function()
      return func(true)
    end
  end

  nnoremap("go", jdtls.organize_imports, bufnr)
  nnoremap("<leader>ev", jdtls.extract_variable, bufnr)
  vnoremap("<leader>ev", w_true(jdtls.extract_variable), bufnr)
  nnoremap("<leader>ec", jdtls.extract_constant, bufnr)
  vnoremap("<leader>ec", w_true(jdtls.extract_constant), bufnr)
  nnoremap("<leader>em", jdtls.extract_method, bufnr)
  vnoremap("<leader>em", w_true(jdtls.extract_method), bufnr)

  jdtls.setup_dap { hotcodereplace = "auto" }
  -- jdtls_dap.setup_dap_main_class_configs()

  jdtls_setup.add_commands()
end

local function get_workspace()
  local project_name = fn.fnamemodify(fn.getcwd(), ":p:h:t")
  return vim.env.HOME .. "/workspace/" .. project_name
end

function java.on_java_opened()
  local share = fn.stdpath "data"
  jdtls.start_or_attach {
    cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens",
      "java.base/java.util=ALL-UNNAMED",
      "--add-opens",
      "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      "/Users/orcan.tiryakioglu/Downloads/jdt-language-server-1.5.0-202110191539/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",
      "-configuration",
      "/Users/orcan.tiryakioglu/Downloads/jdt-language-server-1.5.0-202110191539/config_mac",
      "-data",
      get_workspace(),

      "-noverify",
      "-Xmx1G",
      "-XX:+UseG1GC",
      "-XX:+UseStringDeduplication",
      "-javaagent:/Users/orcan.tiryakioglu/.local/share/lombok/lombok.jar",
      "-Xbootclasspath/a:/Users/orcan.tiryakioglu/.local/share/lombok/lombok.jar",
    },
    on_attach = on_jdtls_attached,
  }
end

function java.setup_jdtls() end

return java
