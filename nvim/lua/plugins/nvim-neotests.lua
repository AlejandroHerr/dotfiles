local function get_project_root()
  local possible_patterns = {
    ".git/",
    "go.mod",
  }

  local current_file = vim.fn.expand("%:p")
  local current_dir = vim.fn.fnamemodify(current_file, ":h")

  -- Debug logging
  print("Current file:", current_file)
  print("Current dir:", current_dir)

  local path = current_dir
  while path ~= "/" do
    print("Checking path:", path)
    for _, pattern in ipairs(possible_patterns) do
      local full_path = path .. "/" .. pattern
      print("Looking for:", full_path)
      if vim.fn.glob(full_path) ~= "" then
        print("Found project root:", path)
        return path
      end
    end
    path = vim.fn.fnamemodify(path, ":h")
  end

  print("No project root found")
  return nil
end

local function load_env_file()
  local env = {}

  local project_root = get_project_root()
  print("Project root:", project_root)

  if not project_root then
    print("Using default env because no project root found")
    return env
  end

  local env_file = project_root .. "/.env.test"
  print("Looking for env file:", env_file)

  local file = io.open(env_file, "r")
  if not file then
    print("Env file not found")
    return env
  end

  print("Reading env file")
  for line in file:lines() do
    local key, value = line:match("^(%w+)=(.+)$")
    if key and value then
      print("Found env var:", key, "=", value)
      env[key] = value
    end
  end
  file:close()

  return env
end

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    { "fredrikaverpil/neotest-golang", version = "*" }, -- Installation
  },
  lazy = false,
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-golang")({
          recursive = true,
          env = function()
            print("Neotest-go loading environment")
            local env = load_env_file()
            print("Final env:", vim.inspect(env))
            return env
          end,
        }), -- Registration
      },
    })

    vim.api.nvim_set_keymap(
      "n",
      "<leader>tr",
      ':lua require("neotest").run.run()<CR>',
      { noremap = true, silent = true, desc = "Run test" }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<leader>ts",
      ':lua require("neotest").run.stop()<CR>',
      { noremap = true, silent = true, desc = "Stop test" }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<leader>tt",
      ':lua require("neotest").summary.toggle()<CR>',
      { noremap = true, silent = true, desc = "Show test summary" }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<leader>to",
      ':lua require("neotest").output.open()<CR>',
      { noremap = true, silent = true, desc = "Open test output" }
    )
  end,
}
