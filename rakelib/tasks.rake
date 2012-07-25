namespace :moth do

  desc "Prints the moth gem version"
  task :version do
    $stdout.puts Moth::VERSION
  end

  desc 'Generates stand-alone configuration file'
  task :generate do
    filename = 'portlets-config.rb'
    FileUtils.cp(
      File.expand_path(File.join(__FILE__,
        %w{.. .. generators moth templates config portlets.rb})),
      filename
      )
    info "Generated #{filename}"
  end

  desc 'Prints portlet configuration'
  task :portlets do
    #portal_info
    info 'Portlet configuration ***********************'
    config = Moth::Config.new
    config.routes = Moth::Util.parse_routes(config)
    portlets = Moth::Parser.new(config).portlets
    Moth::Cli::print_portlets(portlets)
  end

end