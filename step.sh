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


if [ "${GEMFILE_CONTENT}" == "" ]; then
	echo " (!) GEMFILE_CONTENT environment is missing or empty - no Gemfile will be written/used!"
fi

if [ "${__INPUT_FILE__}" == "" ]; then
	echo " [!] __INPUT_FILE__ environment is missing or empty - no Ruby Script defined!"
	exit 1
fi

script_run_dir="$( cd "$( dirname "${__INPUT_FILE__}" )" && pwd )"
echo " (i) script_run_dir: ${script_run_dir}"

(
	print_and_do_command_exit_on_error cd "${script_run_dir}"

	if [ "${GEMFILE_CONTENT}" != "" ]; then
		echo " (i) Writing Gemfile"

		echo "${GEMFILE_CONTENT}" > ./Gemfile

		print_and_do_command_exit_on_error bundle install
	fi
)

print_and_do_command_exit_on_error ruby "${__INPUT_FILE__}"

echo "--- finished ---"
