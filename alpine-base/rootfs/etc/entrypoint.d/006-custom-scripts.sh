#!/usr/bin/env bash

# shellcheck disable=SC1090

## Source script from specified folder
source_scripts() {

    # The folder which can contains scripts
	local script_dir="${1}"

    # Create folder if necessary
	if [ ! -d "${script_dir}" ]; then
		LOG_RUN "mkdir -p ${script_dir}" "INFO"
	fi

    # Find files in the script folder
	script_files="$( find -L "${script_dir}" -type f -iname '*.sh' | sort -u )"

    # Change internal field separator
    IFS='
    '
    # Source files
	for script_file in ${script_files}; do
		script_name="$( basename "${script_file}" )"
        INFO "Sourcing script: ${script_name}"
        source "${script_file}"
	done
}

## Execute script from specified folder
execute_scripts() {

    # The folder which can contains scripts
	local script_dir="${1}"

    # Create folder if necessary
	if [ ! -d "${script_dir}" ]; then
		LOG_RUN "mkdir -p ${script_dir}" "INFO"
	fi

    # Find files in the script folder
	script_files="$( find -L "${script_dir}" -type f -iname '*.sh' | sort -u )"


    # Change internal field separator
    IFS='
    '
    # Excecute files
	for script_file in ${script_files}; do
		script_name="$( basename "${script_file}" )"
        INFO "Executing script: ${script_name}"
		if ! bash "${script_file}"; then
            WARNING "Failed to execute script: ${script_file}"
		fi
	done
}
