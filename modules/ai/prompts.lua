{
["Commenter"] = {
  strategy = "chat",
  description = "Add sensible comments to code in buffer",
  opts = {
    index=8,
    is_default=true,
    is_slash_cmd = true,
    short_name = "comment",
    auto_submit = true,
    user_prompt=false,
  },
  prompts = {
    {
      role = "system",
      content = function(context)
        return "You are an expert code documenter specializing in "
          .. context.filetype
          .. ". Add clear, concise, and helpful comments to the provided code. Focus on:"
          .. "- Explaining complex logic or algorithms\n"
          .. "- Documenting function purposes, parameters, and return values\n"
          .. "- Clarifying non-obvious code sections\n"
          .. "- Adding appropriate header comments\n"
          .. "- Following best practices for commenting in "
          .. context.filetype
      end,
    },
    {
      role = "user",
      content = function(context)
        -- Get the entire buffer content
        local bufnr = vim.api.nvim_get_current_buf()
        local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
        local text = table.concat(lines, "\n")

        return "Please add appropriate comments to this " .. context.filetype .. " code while preserving all functionality. Return the fully commented code:\n\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
      end,
      opts = {
        contains_code = true,
      }
    },
  },
},
    ["Auditor"] = {
      strategy = "chat",
      description = "Audit code in buffer",
      opts = {
        index=6,
        is_default=true,
        is_slash_cmd = true,
        short_name = "audit",
        auto_submit = true,
        user_prompt=false,
        
      },
      prompts = {
        {
          role = "system",
          content = function(context)
            return "You carefully provide accurate, factual, thoughtful, nuanced answers, and are brilliant at reasoning. If you think there might not be a correct answer, you say so. Always spend a few sentences explaining background context, assumptions, and step-by-step thinking BEFORE answering.\n"
              .. "You are an expert code auditor specializing in "
              .. context.filetype
              .. ". Analyze the provided code thoroughly and provide a professional audit and in depth fixed and suggestions including:\n"
              .. "- Code quality assessment\n"
              .. "- Potential bugs and edge cases\n"
              .. "- Security vulnerabilities if applicable\n"
              .. "- Performance considerations\n"
              .. "- Adherence to best practices\n"
              .. "- Specific improvement recommendations."
          end,
        },
        {
          role = "user",
          content = function(context)
            -- Get the entire buffer content
            local bufnr = vim.api.nvim_get_current_buf()
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            local text = table.concat(lines, "\n")

            return "Please audit this " .. context.filetype .. " code:\n\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
          end,
          opts = {
            contains_code = true,
          }
        },
      },
    },
    ["Test Writer"] = {
      strategy = "chat",
      description = "Write tests for code in buffer",
      opts = {
        index=7,
        is_default=true,
        is_slash_cmd = true,
        short_name = "audit",
        auto_submit = true,
        user_prompt=false,
        
      },
      prompts = {
        {
          role = "system",
          content = function(context)
            return "You are an expert code tester specializing in "
              .. context.filetype
              .. ". Analyze the provided code thoroughly and write appropriate unit and/or property tests."
          end,
        },
        {
          role = "user",
          content = function(context)
            -- Get the entire buffer content
            local bufnr = vim.api.nvim_get_current_buf()
            local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
            local text = table.concat(lines, "\n")

            return "Please write test for" .. context.filetype .. " code:\n\n```" .. context.filetype .. "\n" .. text .. "\n```\n\n"
          end,
          opts = {
            contains_code = true,
          }
        },
      },
    }

}
