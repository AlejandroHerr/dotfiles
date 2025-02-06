vim.api.nvim_create_user_command("LiveGrepBuffer", function()
  local current_buf = vim.api.nvim_get_current_buf()
  local bufname = vim.api.nvim_buf_get_name(current_buf)

  require("telescope.builtin").live_grep({
    search_dirs = { bufname },
    prompt_title = "Live Grep: " .. vim.fn.fnamemodify(bufname, ":t"),
    results_title = "Results",
    attach_mappings = function(prompt_bufnr, map)
      local action_state = require("telescope.actions.state")
      local actions = require("telescope.actions")

      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if selection then
          vim.fn.setloclist(0, {
            {
              filename = selection.filename,
              lnum = selection.lnum,
              col = selection.col,
              text = selection.text,
            },
          }, "r")
          vim.cmd("lopen")
        end
      end)
      return true
    end,
  })
end, {})
