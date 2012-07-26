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
    info 'Portlet configuration ***********************'
    cli = Moth::Cli.new
    cli.print_portlets
  end

  desc 'Prints portlet configuration'
  task :make_xml do
    info 'Portlet configuration ***********************'
    cli = Moth::Cli.new
    cli.make_xml
  end

  desc 'Builds and deploys the XML files'
  task :deploy_xml do
    info 'deploying XML files'
    cli = Moth::Cli.new
    files = cli.deploy_xml
    files.each do |f|
      info "-> " + f
    end
  end

  desc 'Builds and deploys the XML files'
  task :deploy do
    cli = Moth::Cli.new
    cli.warble
  end

end