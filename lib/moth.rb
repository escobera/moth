require "rake"
require "rake/tasklib"
require "moth/engine"
require "moth/cli"
require "moth/util"
require "moth/config"
require "moth/liferay"
require "moth/parser"
require "moth/security"
require "moth/portlet"
require "moth/helpers/portlet"
require "moth/helpers/liferay"
require "moth/portlet"
require "rails/routes"

module Moth
end

def info(msg)
  $stdout.puts ' * ' + msg
end
