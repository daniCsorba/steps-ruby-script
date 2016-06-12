#!/bin/bash

THIS_SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG_gemfile_path="${THIS_SCRIPT_DIR}/Gemfile"
CONFIG_ruby_content_file="${THIS_SCRIPT_DIR}/ruby_content_file.rb"

function print_and_do_command {
	echo "-> $ $@"
	$@
}

function print_and_do_command_exit_on_error {
	print_and_do_command $@
	if [ $? -ne 0 ]; then
		echo " [!] Failed!"
		exit 1
	fi
}


if [ "${gemfile_content}" == "" ]; then
	echo " (!) gemfile_content environment is missing or empty - no Gemfile will be written/used!"
fi

if [ "${ruby_content}" == "" ]; then
	echo " [!] ruby_content environment is missing or empty - no Ruby Script defined!"
	exit 1
fi

if [ ! -z "${script_run_dir}" ] ; then
	print_and_do_command_exit_on_error cd "${script_run_dir}"
fi

set -e
if [[ "${gemfile_content}" != "" ]]; then
	echo "-> Writing Gemfile"
	echo "${gemfile_content}" > "${CONFIG_gemfile_path}"
	echo "$ bundle install"
	BUNDLE_GEMFILE="${CONFIG_gemfile_path}" bundle install
fi

echo -n "${ruby_content}" > "${CONFIG_ruby_content_file}"
set +e

cmd_ex_code=0
if [[ "${gemfile_content}" != "" ]]; then
	BUNDLE_GEMFILE="${CONFIG_gemfile_path}" bundle exec ruby "${CONFIG_ruby_content_file}"
	cmd_ex_code=$?
else
	ruby "${CONFIG_ruby_content_file}"
	cmd_ex_code=$?
fi

echo "--- finished ---"

exit $cmd_ex_code