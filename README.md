Nice Chef Formatter
===================

Formatter for chef with execution times for every cookbook/recipe and simplified output.

Color codes:
- Green, resource had nothing to do. It was already applied
- Yellow, resource has done work. Applied
- Blue, resource was skipped due to conditional (only_if, not_if, ...)

Usage
=====

Install the gem:

    gem install nice-chef-formatter

If you are using Omnibus Chef you need to specify the full path to the `gem`
binary:

    /opt/chef/embedded/bin/gem install nice-chef-formatter

Or write a cookbook to install it using the `chef_gem` resource, if that's
how you roll.

Then add the following to your `/etc/chef/client.rb` file:

    gem 'nice-chef-formatter'
    require 'nice-chef-formatter'

This enables the formatter, but doesn't use it by default.

Acknowledgements
================

* Andrea Campi (@andreacampi) for the [nyan-cat-chef-formatter](https://github.com/andreacampi/nyan-cat-chef-formatter) that was the original inspiration

License and Authors
===================

Author:: Nadir Lloret (<nadir.lloret@gmail.com>)
License:: Apache 2.0