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

if [ "${ruby_content}" == "" ]; then
	echo " [!] ruby_content environment is missing or empty - no Ruby Script defined!"
	exit 1
fi

if [ ! -z "${script_run_dir}" ] ; then
	print_and_do_command_exit_on_error cd "${script_run_dir}"
fi

if [[ "${gemfile_content}" != "" ]]; then
	echo " (i) Writing Gemfile"

	echo "${gemfile_content}" > ./Gemfile

	print_and_do_command_exit_on_error bundle install
fi

echo "${ruby_content}" > ./__tmp_ruby_content_file.rb

if [[ "${gemfile_content}" != "" ]]; then
	print_and_do_command_exit_on_error bundle exec ruby ./__tmp_ruby_content_file.rb
else
	print_and_do_command_exit_on_error ruby ./__tmp_ruby_content_file.rb
fi

rm ./__tmp_ruby_content_file.rb

echo "--- finished ---"
