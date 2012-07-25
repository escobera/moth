# encoding: utf-8
#--
# Copyright (c) 2012 Rafael Barbosa
# This source code is available under the MIT license.
# See the file LICENSE.txt for details.
#++
require 'spec_helper'

describe Moth::Cli do

  let (:cli) do
    cli = Moth::Cli.new
    cli.config.rails_root = File.join(File.dirname(__FILE__),'dummy')
    cli
  end

  it "should print portlet nams" do
    capture { cli.print_portlets }.should =~ /\/caterpillar\/test_bench/
  end

  it "should make XML" do
    portlet = {:name => 'portlet_test_bench'}
    @task.config.instances << portlet
    @task.config.session_secret = {:key => 'test', :secret => 'test_secret'}

    Dir.chdir(@tmpdir)
    Dir.glob('*.xml').size.should == 0

    silence { cli.makexml }

    File.exists?('portlet-ext.xml').should == true
    File.exists?('liferay-portlet-ext.xml').should == true
    File.exists?('liferay-display.xml').should == true
    File.size('portlet-ext.xml').should > 0
    File.size('liferay-portlet-ext.xml').should > 0
    File.size('liferay-display.xml').should > 0
  end


end