# # encoding: utf-8

# require 'spec_helper'

# describe ErrorCollection, '#added?' do
#   let(:object)      { described_class.new base }
#   let(:base)        { User.new }
#   let(:field)       { :first_name }
#   let(:message)     { :invalid }
#   let(:options)     { { message: 'no good' } }

#   context 'with attribute' do
#     before        { object.add(field, message, options) }

#     it            { should be_a ErrorMessage }
#     its(:type)    { should eql message }
#     its(:message) { should eql options[:message] }
#   end

#   context 'with attribute and message' do
#     before        { object.add(field, message, options) }

#     it            { should be_a ErrorMessage }
#     its(:type)    { should eql message }
#     its(:message) { should eql options[:message] }
#   end

#   context 'with attribute, message, and options' do
#     before        { object.add(field, message, options) }

#     it            { should be_a ErrorMessage }
#     its(:type)    { should eql message }
#     its(:message) { should eql options[:message] }
#   end
# end
