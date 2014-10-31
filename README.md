steps-ruby-script
=================

Bitrise Step to run a Ruby script with optional Gemfile.

This Step is part of the [Open StepLib](http://www.steplib.com/), you can find its StepLib page [here](http://www.steplib.com/step/ruby-script-with-gemfile)


## How it works?

1. Saves the `${GEMFILE_CONTENT}` into file.
2. Calls *bundle install*
3. Runs the Ruby script (which's path is stored in `__INPUT_FILE__`)


## Important!

Bitrise expands input Environment Variables. The *GEMFILE_CONTENT* environment is passed as a normal Environment Variable so any Environment Variable referencing will be expanded.

This means: you **can't** use **$** in the Gemfile (if followed by a string right away, like: *$HOME*).


## Note

`__INPUT_FILE__` is a special Bitrise input.
Bitrise will write the value of this Environment Variable into a file and provide the file's path for the Step instead of providing the value directly.
