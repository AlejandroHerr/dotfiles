function _wezterm_nvim_dir
    set selected_dir (_fzf_working_dirs)

    if test -n "$selected_dir"
        wezterm cli spawn --cwd $selected_dir nvim
    end
end
