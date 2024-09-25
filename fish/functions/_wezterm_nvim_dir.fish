function _wezterm_nvim_dir
    set selected_dir (_fzf_working_dirs)

    if test -n "$selected_dir"
        # cd $selected_dir
        cd $selected_dir 
        wezterm cli set-tab-title (echo nvim (prompt_pwd))
        nvim

    end
end
