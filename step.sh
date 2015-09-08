#!/bin/bash

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

if [ "${input_file}" == "" ]; then
	echo " [!] input_file environment is missing or empty - no Ruby Script defined!"
	exit 1
fi

script_run_dir="$( cd "$( dirname "${input_file}" )" && pwd )"
echo " (i) script_run_dir: ${script_run_dir}"

(
	print_and_do_command_exit_on_error cd "${script_run_dir}"

	if [ "${gemfile_content}" != "" ]; then
		echo " (i) Writing Gemfile"

		echo "${gemfile_content}" > ./Gemfile

		print_and_do_command_exit_on_error bundle install
	fi
)

print_and_do_command_exit_on_error ruby "${input_file}"

echo "--- finished ---"
