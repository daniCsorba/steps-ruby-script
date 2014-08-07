steps-ruby-script
=================

Bitrise Step to run a Ruby script with optional Gemfile.


## How it works?

1. Saves the `${GEMFILE_CONTENT}` into ./Gemfile
2. Saves the `${RUBYSCRIPT_CONTENT}` into ./script.rb
3. calls *bundle install*
4. runs the ./script.rb with ruby
