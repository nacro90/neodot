return {
  dir = "/home/nacro90/Projects/codecompanion.nvim",
  dev = true,
  enabled = true,
  keys = {
    -- {
    --   "<leader>cc",
    --   "<Cmd>CodeCompanionChat Toggle<CR>",
    --   desc = "Toggle CodeCompanion Chat",
    -- },
    -- {
    --   "<leader>cc",
    --   "<Cmd>CodeCompanionChat Add<CR>",
    --   desc = "Add to CodeCompanion Chat",
    --   mode = "v",
    -- },
  },
  cmd = "CodeCompanionChat",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/codecompanion-history.nvim",
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
      keys = {
        {
          "<C-v>",
          function()
            require("img-clip").paste_image()
          end,
          desc = "Paste image from clipboard",
          ft = "codecompanion",
        },
      },
      opts = {
        default = {
          dir_path = function()
            -- Use XDG cache or /tmp - never project directory
            local cache = vim.env.XDG_CACHE_HOME or (vim.env.HOME .. "/.cache")
            return cache .. "/codecompanion-images"
          end,
        },
        filetypes = {
          codecompanion = {
            prompt_for_file_name = false,
            template = "/image $FILE_PATH",
            use_absolute_path = true,
          },
        },
      },
    },
  },
  opts = {
    display = {
      chat = {
        show_settings = true,
        show_token_count = true,
        show_reasoning = true,
        fold_reasoning = false,
      },
    },
    -- Override dangerous tool restrictions for full YOLO mode
    -- (equivalent to --dangerously-skip-permissions)
    tools = {
      ["cmd_runner"] = {
        opts = {
          allowed_in_yolo_mode = true, -- WARNING: allows shell commands without approval
        },
      },
      ["delete_file"] = {
        opts = {
          allowed_in_yolo_mode = true, -- WARNING: allows file deletion without approval
        },
      },
    },
    strategies = {
      chat = {
        adapter = "claude_code",
        model = "claude-opus-4-5-20251101",
      },
      inline = {
        adapter = "copilot",
      },
    },
    adapters = {
      acp = {
        claude_code = function()
          vim.env.ANTHROPIC_MODEL = "claude-opus-4-5-20251101"
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
      history = {
        enabled = true,
        opts = {
          keymap = "gh",
          save_chat_keymap = "sc",
          auto_save = true,
          expiration_days = 30,
          picker = "telescope",
        },
      },
      -- mcphub = {
      --   callback = "mcphub.extensions.codecompanion",
      --   opts = {
      --     show_result_in_chat = true,
      --     make_vars = true,
      --     make_slash_commands = true,
      --     make_tools = true,
      --     show_server_tools_in_chat = true,
      --   },
      -- },
    },
  },
  config = function(_, opts)
    require("codecompanion").setup(opts)

    local spinner = require "nacro.codecompanion_spinner"
    local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "CodeCompanionChatSubmitted",
      group = group,
      callback = function(_)
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


