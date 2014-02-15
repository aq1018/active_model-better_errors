# encoding: utf-8

require 'spec_helper'

describe Errors do
  subject { described_class }

  its(:included_modules) { should include Enumerable }
  its(:included_modules) { should include Helper }
  its(:included_modules) { should include Emulation }
end
