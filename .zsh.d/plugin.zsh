function plug() {
    local plugin_dir=$1
    local plugin_script=$2

    if [ -d "${plugin_dir}" ]; then
        [[ -s "${plugin_dir}/${plugin_script}" ]] && echo "source '${plugin_dir}/${plugin_script}';"
    fi
    echo ':'
}
