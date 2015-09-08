# Ruby Script

The new Ruby Script step.

Bitrise Step to run a Ruby script with optional Gemfile.

Can be run directly with the [bitrise CLI](https://github.com/bitrise-io/bitrise),
just `git clone` this repository, `cd` into it's folder in your Terminal/Command Line
and call `bitrise run test`.

*Check the `bitrise.yml` file for required inputs which have to be
added to your `.bitrise.secrets.yml` file!*


## How it works?

1. Saves the `${gemfile_content}` into file.
2. Calls *bundle install*
3. Runs the Ruby script (with `bundle exec ruby`)
