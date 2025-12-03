return {
  "olimorris/codecompanion.nvim",
  keys = {
    { "<leader>cc", "<cmd>CodeCompanionChat<cr>", desc = "Toggle CodeCompanion Chat" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    {
      "ravitemer/mcphub.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      build = "npm install -g mcp-hub@latest",
      commands = "MCPHub",
      config = function()
        local _, _ = pcall(function()
          require("mcphub").setup {
            cmd = "/home/nacro90/.config/nvm/versions/node/v20.11.0/bin/mcp-hub",
            config = vim.fn.expand "~/.claude.json",
          }
        end)
      end,
    },
    {
      "HakonHarnes/img-clip.nvim",
      opts = {
        filetypes = {
          codecompanion = {
            prompt_for_file_name = false,
            template = "[Image]($FILE_PATH)",
            use_absolute_path = true,
          },
        },
      },
    },
  },
  opts = {
    strategies = {
      chat = { adapter = "claude_code" },
      inline = { adapter = "copilot" },
    },
    adapters = {
      http = {
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            env = {
              CLAUDE_CODE_OAUTH_TOKEN =
              "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",
            },
          })
        end,
      },
      acp = {
        claude_code = function()
          return require("codecompanion.adapters").extend("claude_code", {
            env = {
              CLAUDE_CODE_OAUTH_TOKEN =
              "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",
            },
            commands = {
              default = {
                "/home/nacro90/.config/nvm/versions/node/v20.11.0/bin/claude-code-acp",
              },
            },
          })
        end,
      },
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          show_result_in_chat = true,
          make_vars = true,
          make_slash_commands = true,
          make_tools = true,
          show_server_tools_in_chat = true,
        },
      },
    },
  },
  config = function(_, opts)
    require("codecompanion").setup(opts)

    local spinner = require "nacro.codecompanion_spinner"
    local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})
    
    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "CodeCompanionChatSubmitted",
      group = group,
      callback = function(request)
        spinner.start()
        vim.cmd "stopinsert"
      end,
    })
    
    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "CodeCompanionRequestFinished",
      group = group,
      callback = function()
        spinner.stop()
      end,
    })
  end,
}
