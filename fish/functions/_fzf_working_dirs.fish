function _fzf_working_dirs
    set dirs $WORKING_DIRS
    set dirs $dirs (fd . $dirs -t d)

    printf "%s\n" $dirs | sort -u | fzf --preview 'ls -lah --color=always {}'
end
