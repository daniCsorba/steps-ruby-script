# Ruby Script

The new Ruby Script step.

Bitrise Step to run a Ruby script with optional Gemfile.

This Step is part of the [Open StepLib](http://www.steplib.com/), you can find its StepLib page [here](http://www.steplib.com/step/ruby-script-with-gemfile)


Can be run directly with the [bitrise CLI](https://github.com/bitrise-io/bitrise),
just `git clone` this repository, `cd` into it's folder in your Terminal/Command Line
and call `bitrise run test`.

*Check the `bitrise.yml` file for required inputs which have to be
added to your `.bitrise.secrets.yml` file!*


## How it works?

1. Saves the `${gemfile_content}` into file.
2. Calls *bundle install*
3. Runs the Ruby script (which's path is stored in `input_file`)


## Important!

Bitrise expands input Environment Variables. The *gemfile_content* environment is passed as a normal Environment Variable so any Environment Variable referencing will be expanded.

This means: you **can't** use **$** in the Gemfile (if followed by a string right away, like: *$HOME*).


## Note

`input_file` is a special Bitrise input.
Bitrise will write the value of this Environment Variable into a file and provide the file's path for the Step instead of providing the value directly.
