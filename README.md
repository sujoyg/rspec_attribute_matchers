# Example

## `Gemfile`
    group :development do
      ...
      gem 'rspec_attribute_matchers', '~> 0.0.0'
      ...
    end

## `spec/spec_helper.rb`

	require 'rspec_attribute_matchers'

	RSpec.configure do |config|
	  ...
	  config.include RSpecAttributeMatchers, :type => :model
	  ...
	end


## `app/models/store.rb`

	require 'spec_helper'

	describe Store do
	  it { should have_attribute(:title)
	  it { should have_attribute(:description).with(:type => :string, :null => false) }
	  it { should have_attribute(:url).with(:type => :string, :limit => 1024) }
	  it { should have_attribute(:open).with(:type => :boolean) }
	end

