namespace :moth do

  desc "Prints the moth gem version"
  task :version do
    $stdout.puts Moth::VERSION
  end

  desc 'Generates stand-alone configuration file'
  task :generate do
    filename = 'portlets.rb'
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
    cli = Moth::Cli.new
    cli.print_portlets
  end

end