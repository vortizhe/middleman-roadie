# Middleman Roadie

[Roadie](https://github.com/Mange/roadie) extension wrapper for [Middleman](https://middlemanapp.com/).

## Installation

Install the gem as usual: put `gem 'middleman-roadie'` in Gemfile, then run `bundle install`.

Put `activate :roadie` in config.rb (*not* in the `configure :build` block).

## Usage

Use a custom layout for email rendering page `'/email/*', layout: :email` in config.rb.

**Important:** link stylesheets to be inlined using `stylesheet_inline_tag 'your_css'` helper.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
