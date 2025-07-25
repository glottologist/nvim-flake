{
  config,
  lib,
  ...
}:
with lib;
with builtins; let
  cfg = config.vim.ai;
in {
  config = mkIf (cfg.claude-code.enable) {
    vim.startPlugins = ["claude-code-nvim"];
    vim.luaConfigRC.claude-code = lib.nvim.dag.entryAnywhere ''
      -- Safely load claude-code with comprehensive error handling
      local function safe_setup_claude_code()
        local ok, claude_code = pcall(require, "claude-code")
        if not ok then
          vim.notify("Failed to load claude-code: " .. tostring(claude_code), vim.log.levels.ERROR)
          return false
        end

        local setup_ok, setup_err = pcall(function()
          claude_code.setup({
        window = {
          split_ratio = 0.3,      -- Percentage of screen for the terminal window (height for horizontal, width for vertical splits)
          position = "botright",  -- Position of the window: "botright", "topleft", "vertical", "float", etc.
          enter_insert = true,    -- Whether to enter insert mode when opening Claude Code
          hide_numbers = true,    -- Hide line numbers in the terminal window
          hide_signcolumn = true, -- Hide the sign column in the terminal window
          float = {
            width = "80%",        -- Width: number of columns or percentage string
            height = "80%",       -- Height: number of rows or percentage string
            row = "center",       -- Row position: number, "center", or percentage string
            col = "center",       -- Column position: number, "center", or percentage string
            relative = "editor",  -- Relative to: "editor" or "cursor"
            border = "rounded",   -- Border style: "none", "single", "double", "rounded", "solid", "shadow"
          },
        },
        refresh = {
          enable = true,           -- Enable file change detection
          updatetime = 100,        -- updatetime when Claude Code is active (milliseconds)
          timer_interval = 1000,   -- How often to check for file changes (milliseconds)
          show_notifications = true, -- Show notification when files are reloaded
        },
        git = {
          use_git_root = true,     -- Set CWD to git root when opening Claude Code (if in git project)
        },
        shell = {
          separator = '&&',        -- Command separator used in shell commands
          pushd_cmd = 'pushd',     -- Command to push directory onto stack (e.g., 'pushd' for bash/zsh, 'enter' for nushell)
          popd_cmd = 'popd',       -- Command to pop directory from stack (e.g., 'popd' for bash/zsh, 'exit' for nushell)
        },
        command = "claude",        -- Command used to launch Claude Code
        command_variants = {
          continue = "--continue", -- Resume the most recent conversation
          resume = "--resume",     -- Display an interactive conversation picker
          verbose = "--verbose",   -- Enable verbose logging with full turn-by-turn output
        },
        -- Keymaps
        keymaps = {
          toggle = {
            normal = "<C-,>",       -- Normal mode keymap for toggling Claude Code, false to disable
            terminal = "<C-,>",     -- Terminal mode keymap for toggling Claude Code, false to disable
            variants = {
              continue = "<leader>cC", -- Normal mode keymap for Claude Code with continue flag
              verbose = "<leader>cV",  -- Normal mode keymap for Claude Code with verbose flag
            },
          },
          window_navigation = true, -- Enable window navigation keymaps (<C-h/j/k/l>)
          scrolling = true,         -- Enable scrolling keymaps (<C-f/b>) for page up/down
        }
          })
        end)

        if not setup_ok then
          vim.notify("Failed to setup claude-code: " .. tostring(setup_err), vim.log.levels.ERROR)
          return false
        end

        return true
      end

      -- Only setup if successful
      if not safe_setup_claude_code() then
        vim.notify("Claude Code plugin disabled due to errors", vim.log.levels.WARN)
      end
    '';
  };
}
