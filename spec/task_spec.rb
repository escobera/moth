# encoding: utf-8
#--
# Copyright (c) 2010 Mikael Lammentausta
# This source code is available under the MIT license.
# See the file LICENSE.txt for details.
#++
require 'spec_helper'
require 'rake'
require 'tmpdir'

describe "Cli tasks" do
  before(:all) do
    @liferay_xml_dir = File.dirname(File.expand_path(__FILE__)) + '/../xml'
    load File.join(File.dirname(__FILE__),'..','rakelib','tasks.rake')
  end

  before(:each) do
    #@rake = Rake::Application.new
    # Rake.application = @rake
    # verbose(false)
    @task = Moth::CliTask.new
    @pwd = Dir.pwd
    @tmpdir = Dir.tmpdir + '/moth'
    Dir.mkdir(@tmpdir) unless File.exists?(@tmpdir)
  end

  after(:each) do
    FileUtils.rm_rf @tmpdir
    Dir.chdir @pwd
  end

  it "should print version" do
    capture { Rake::Task["moth:version"].invoke }.should =~ /#{Moth::VERSION}/
  end

  it "should create a conf file" do
    Dir.chdir(@tmpdir)
    fn = "portlets-config.rb"
    File.exist?(fn).should == false
    silence { Rake::Task["moth:generate"].invoke }
    File.exist?(fn).should == true
  end

  it "should print no route" do
    portlet = {
        :name     => 'portlet_test_bench',
    }
    @task.config.instances << portlet
    capture { Rake::Task["moth:portlets"].invoke }.should =~ /no route for portlet_test_bench/
  end

  it "should print routes" do
    portlet = {
        :name     => 'portlet_test_bench',
    }
    @task.config.instances << portlet
    @task.config.rails_root = File.join(File.dirname(__FILE__),'..','app1')
    capture { Rake::Task["portlets"].invoke }.should =~ /\/caterpillar\/test_bench/
  end

  it "should parse routes without config.rails_root" do
    portlet = {
        :name     => 'portlet_test_bench',
        :rails_root => File.join(File.dirname(__FILE__),'..','app1')
    }
    @task.config.instances << portlet
    capture { Rake::Task["portlets"].invoke }.should =~ /\/caterpillar\/test_bench/
  end

  it "should parse routes" do
    config = Moth::Config.new
    config.rails_root = File.join(File.dirname(__FILE__),'dummy')
    config.instances = [
    {
        :name     => 'portlet_test_bench',
        :title    => 'Rails-portlet test bench',
        :category => 'Moth',
        :rails_root => File.join(File.dirname(__FILE__),'dummy')
    },
    ]
    routes = Moth::Util.parse_routes(config)
    routes.size.should == 3 # moth, test_bench and dummy_app

    paths = routes.map {|r| r[:path]}
    paths.each do |path|
      route = routes.select {|r| r[:path] == path }.first

      case path
      when '/caterpillar'
        route[:reqs][:controller].should == 'Moth::Application'
        route[:reqs][:action].should == 'index'

      when '/caterpillar/test_bench'
        route[:reqs][:controller].should == 'Moth::Application'
        route[:reqs][:action].should == 'portlet_test_bench'

      when '/bear/hungry'
        route[:reqs][:controller].should == 'Bear'
        route[:reqs][:action].should == 'hungry'

      when '/otters/adorable'
        route[:reqs][:controller].should == 'Otter'
        route[:reqs][:action].should == 'adorable'

      end
    end
  end

  it "should define Tomcat WEB-INF location" do
    container_root = @tmpdir

    @task.config.container = Moth::Liferay
    @task.config.container.root = container_root
    @task.config.container.root.should == container_root

    @task.config.container.server = 'Tomcat'
    @task.config.container.deploy_dir.should == container_root + '/webapps'
    @task.config.container.WEB_INF.should == container_root + '/webapps/ROOT/WEB-INF'
  end

  it "should define JBoss/Tomcat WEB-INF location" do
    container_root = @tmpdir

    @task.config.container = Moth::Liferay
    @task.config.container.root = container_root
    @task.config.container.root.should == container_root

    @task.config.container.server = 'JBoss/Tomcat'
    # no server_dir!
    lambda { @task.config.container.WEB_INF }.should raise_error(RuntimeError, /Please configure server_dir/)

    @task.config.container.server_dir = 'server/default/deploy/ROOT.war'
    @task.config.container.WEB_INF.should == container_root + '/server/default/deploy/ROOT.war/WEB-INF'
  end

  it "should make XML" do
    portlet = {:name => 'portlet_test_bench'}
    @task.config.instances << portlet
    @task.config.session_secret = {:key => 'test', :secret => 'test_secret'}

    Dir.chdir(@tmpdir)
    Dir.glob('*.xml').size.should == 0

    silence { Rake::Task["makexml"].invoke }

    File.exists?('portlet-ext.xml').should == true
    File.exists?('liferay-portlet-ext.xml').should == true
    File.exists?('liferay-display.xml').should == true
    File.size('portlet-ext.xml').should > 0
    File.size('liferay-portlet-ext.xml').should > 0
    File.size('liferay-display.xml').should > 0
  end

  it "should deploy XML on Tomcat" do
    portlet = {:name => 'portlet_test_bench'}
    @task.config.instances << portlet
    @task.config.session_secret = {:key => 'test', :secret => 'test_secret'}

    container_root = @tmpdir
    @task.config.container.root = container_root
    @task.config.container.server = 'Tomcat'

    web_inf = container_root + '/webapps/ROOT/WEB-INF'
    @task.config.container.WEB_INF.should == web_inf

    File.exists?(web_inf).should == false
    FileUtils.cp_r(
      @liferay_xml_dir + '/liferay-portal-5.2.3/tomcat-6.0.18/webapps',
      container_root)
    File.exists?(web_inf).should == true

    silence { Rake::Task["deploy:xml"].invoke }

    Dir.chdir(web_inf)
    File.exists?('portlet-ext.xml').should == true
    File.exists?('liferay-portlet-ext.xml').should == true
    File.exists?('liferay-display.xml').should == true
    File.size('portlet-ext.xml').should > 0
    File.size('liferay-portlet-ext.xml').should > 0
    File.size('liferay-display.xml').should > 0
  end

end
