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

if [ "${RUBYSCRIPT_CONTENT}" == "" ]; then
	echo " [!] RUBYSCRIPT_CONTENT environment is missing or empty!"
	exit 1
fi


if [ "${GEMFILE_CONTENT}" != "" ]; then
	echo " (i) Writing Gemfile"

cat >./Gemfile <<EOL
${GEMFILE_CONTENT}
EOL

	print_and_do_command_exit_on_error bundle install
fi

echo " (i) Writing the Ruby script file"
cat >./script.rb <<EOL
${RUBYSCRIPT_CONTENT}
EOL

print_and_do_command_exit_on_error ruby ./script.rb

echo "--- finished ---"
