function fdir
    set selected_dir (_fzf_working_dirs)

    if test -n "$selected_dir"
        cd $selected_dir
    end
end
