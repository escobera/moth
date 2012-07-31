# Moth

This project rocks and uses MIT-LICENSE.

## Usage

Add Moth to your Gemfile

    gem "moth", :git => "git://github.com/escobera/moth.git"

Generate the portlet config

    bundle exec rake moth:generate

Configure `config/portlets.rb` to match your environment.

Deploy only XML files

    rvmsudo bundle exec rake moth:deploy_xml

Or the whole Rails app as a servlet (requires JRuby)

    rvmsudo bundle exec rake moth:deploy
