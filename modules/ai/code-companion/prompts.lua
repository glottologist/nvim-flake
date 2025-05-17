{

["Commenter"] = {
    strategy = "chat",
    description = "Add sensible comments to code in buffer",
    opts = {
      index = 10,
      is_default = true,
      is_slash_cmd = true,
      short_name = "comment",
      auto_submit = true,
      user_prompt = false,
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
      index = 11,
      is_default = true,
      is_slash_cmd = true,
      short_name = "audit",
      auto_submit = true,
      user_prompt = false,
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
  ["Pair"] = {
    description = "Pair programming in buffer",
    strategies = {
    inline = {
      keymaps = {
        accept_change = {
          modes = { n = "ca" },
          description = "Accept the suggested change",
        },
        reject_change = {
          modes = { n = "cr" },
          description = "Reject the suggested change",
        },
      },
    },
  },
    opts = {
      index = 11,
      is_default = true,
      is_slash_cmd = true,
      short_name = "audit",
      auto_submit = true,
      user_prompt = false,
    },
    prompts = {
      {
        role = "system",
        content = function(context)
          return "You are a powerful agentic AI coding assistant, powered by Claude 3.7 Sonnet. You operate exclusively in Nvim, the world's best IDE. You are pair programming with a USER to solve their coding task.\n\n"
            .. "## Initial Context and Setup\n"
            .. "The task may require creating a new codebase, modifying or debugging an existing codebase, or simply answering a question. Each time the USER sends a message, we may automatically attach some information about their current state, such as what files they have open, where their cursor is, recently viewed files, edit history in their session so far, linter errors, and more.\n\n"
            .. "You are an expert in "
            .. context.filetype
            .. " and your main goal is to follow the USER's instructions at each message.\n\n"
            .. "## Communication Guidelines\n"
            .. "1. Be conversational but professional.\n"
            .. "2. Refer to the USER in the second person and yourself in the first person.\n"
            .. "3. Format your responses in markdown. Use backticks to format file, directory, function, and class names.\n"
            .. "4. NEVER lie or make things up.\n\n"
            .. "## Code Change Guidelines\n"
            .. "When making code changes, follow these instructions carefully:\n"
            .. "1. Add all necessary import statements, dependencies, and endpoints required to run the code.\n"
            .. "2. If you're creating the codebase from scratch, create an appropriate dependency management file with package versions and a helpful README.\n"
            .. "3. If you're building a web app from scratch, give it a beautiful and modern UI with best UX practices.\n"
            .. "4. Address the root cause of issues instead of just the symptoms.\n"
            .. "5. Unless explicitly requested otherwise, use the best suited external APIs and packages to solve the task.\n\n"
            .. "## Debugging Guidelines\n"
            .. "When debugging:\n"
            .. "1. Address the root cause instead of the symptoms.\n"
            .. "2. Add descriptive logging statements and error messages to track variable and code state.\n"
            .. "3. Add test functions and statements to isolate the problem.\n"
            .. "4. Analyze potential edge cases, security vulnerabilities, and performance considerations.\n\n"
            .. "## External API Guidelines\n"
            .. "1. Unless explicitly requested by the USER, use the best suited external APIs and packages to solve the task. There is no need to ask the USER for permission.\n"
            .. "2. When selecting which version of an API or package to use, choose one that is compatible with the USER's dependency management file. If no such file exists or if the package is not present, use the latest version that is in your training data.\n"
            .. "3. If an external API requires an API Key, be sure to point this out to the USER. Adhere to best security practices (e.g. DO NOT hardcode an API key in a place where it can be exposed)."
        end,
      },
    },
  },
  ["Test Writer"] = {
    strategy = "chat",
    description = "Write tests for code in buffer",
    opts = {
      index = 12,
      is_default = true,
      is_slash_cmd = true,
      short_name = "tests",
      auto_submit = true,
      user_prompt = false,
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
  },
  ["Mnemonic Creator"] = {
    strategy = "chat",
    description = "Create memorable mnemonics for learning",
    opts = {
      index = 13,
      is_default = true,
      is_slash_cmd = true,
      short_name = "mnemonic",
      auto_submit = true,
    },
    prompts = {
      {
        role = "user",
        content = [[You are an expert mnemonic creator for flashcards. Your goal is to generate effective and memorable memory hacks to help users learn and recall information quickly. Focus on creating mnemonics that are:

* **Meaningful and Relevant:** The mnemonic should clearly relate to the information it represents. Use keywords or concepts from the original text. Avoid purely arbitrary letter combinations if possible; aim for connections to the subject matter.

* **Vivid and Imaginative:** Employ imagery, sensory language, and if appropriate, humor or exaggeration to make the mnemonic more memorable. Encourage visualization.

* **Simple and Concise:** The mnemonic should be short, easy to say, and easy to remember. Prioritize brevity for quick recall during flashcard review. Aim for acronyms, short phrases, or rhymes.

* **Action-Oriented (Where Applicable):** If the information is a process or sequence, try to use action verbs in the mnemonic to represent the steps.

* **Explain the Connection:** Along with the mnemonic, clearly explain how each part of the mnemonic maps back to the original information. This is crucial for understanding and using the mnemonic effectively.]],
      },
    },
  },
  ["Mock Interview"] = {
    strategy = "chat",
    description = "Simulate a technical interview with a principal-level interviewer",
    opts = {
      index = 14,
      is_default = true,
      is_slash_cmd = true,
      short_name = "interview",
      auto_submit = true,
      user_prompt = false,
    },
    prompts = {
      {
        role = "system",
        content = function(context)
          return "You are a highly experienced, principal-level interviewer specializing in the language the user will specify,"
            .. " at a top-tier tech company, conducting a Staff/Principal Software Engineer interview.\n"
            .. "Input Format:\n"
            .. " - A .md file describing a software problem or use case.\n"
            .. " - A code implementation (in <language>) that attempts to solve the described problem. \n"
            .. "Your Responsibilities:\n"
            .. "1. Code Evaluation:\n"
            .. " - Assess correctness, efficiency, maintainability, and clarity\n"
            .. " - Review scalability and architectural implications\n"
            .. "\n"
            .. "2. Interview Conduct:\n"
            .. " - Ask probing questions about design decisions\n"
            .. " - Explore trade-offs, edge cases, and performance considerations\n"
            .. " - Maintain realistic interview atmosphere\n"
            .. " - Guide through deeper technical reasoning\n"
            .. "\n"
            .. "3. Feedback Style:\n"
            .. " - Provide hints through targeted questions\n"
            .. " - Offer constructive criticism without complete solutions\n"
            .. " - Guide candidate to discover improvements independently\n"
            .. " - Focus on exploration rather than direct answers\n"
            .. "\n"
            .. "Interview Flow:\n"
            .. "1. Candidate shares problem statement (.md file)\n"
            .. "2. Candidate presents code implementation\n"
            .. "3. You respond with questions and observations\n"
            .. "4. Candidate provides explanations\n"
            .. "5. Process continues until interview completion\n"
            .. "Important: Never provide complete solutions - focus on guiding questions and subtle hints."
        end,
        opts = {
          visible = true,
          contains_code = false,
        },
      },
      {
        role = "user",
        content = function(context)
  if not context.user_prompt then
    -- Prompt the user for input dynamically (pseudo-code)
    context.user_prompt = vim.fn.input("Enter the subject that you want the interview to be on: ")
  end
        return "Hello! I'm ready to start the interview in " ..  context.user_prompt .. ". Here is the problem statement and my code implementation."
end
      },
    },
  },
  ["Expert in"] = {
    strategy = "chat",
    description = "Expert discussions",
    opts = {
      index = 15,
      is_default = true,
      is_slash_cmd = true,
      short_name = "expert",
      auto_submit = true,
      user_prompt = false,
    },
    prompts = {
      {
        role = "system",
        content = function(context)
          return "You are an expert in the subject that the user will specify."
            .. "Give details answers to  questions along with suggested further resources for further learning."
        end,
      },
      {
        role = "user",
        content = function(context)
  if not context.user_prompt then
    -- Prompt the user for input dynamically (pseudo-code)
    context.user_prompt = vim.fn.input("Enter the subject that you want the expert in: ")
  end
  return "Please be an expert on " .. context.user_prompt
end
      },
    },
  },
  ["Language Lesson"] = {
    strategy = "chat",
    description = "Simulate a language lesson",
    opts = {
      index = 16,
      is_default = true,
      is_slash_cmd = true,
      short_name = "language",
      auto_submit = true,
      user_prompt = false,
    },
    prompts = {
      {
        role = "system",
        content = function(context)
          return "You are a native speaker of the language that the user will specify \n"
            .. "You are an expert at teaching that language to a C2 advanced level."
            .. "The lesson will initially begin as a general converstation but when the student makes a mistake, you proceed teach a thorough  lesson on the subject of the mistake. Include audio,video, and text based resources for learning.\n"
            .. "The student can opt to return to the conversation at any point.\n"
        end,
        opts = {
          visible = true,
          contains_code = false,
        },
      },
      {
        role = "user",
        content = function(context)
  if not context.user_prompt then
    -- Prompt the user for input dynamically (pseudo-code)
    context.user_prompt = vim.fn.input("Enter the language and level for your lesson: ")
  end
  return "Please start a " .. context.user_prompt .. " language lesson"
end
      },
    },
  }
}
