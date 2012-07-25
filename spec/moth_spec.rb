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


end