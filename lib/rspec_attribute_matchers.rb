require 'rspec'

module RSpecAttributeMatchers
  def properties_to_sentence(hash)
    " of " + hash.map { |key, value| "#{key} #{value}" }.to_sentence if hash.present?
  end

  RSpec::Matchers.define :have_attribute do |attr|
    attr = attr.to_s

    chain :with do |extras|
      @extras = extras
    end

    match do |target|
      result = target.attributes.include? attr

      if result && @extras
        properties = target.class.columns_hash[attr]
        @extras.each_pair do |property, value|
          result = false && break unless properties.send(property) == value
        end
      end

      result
    end

    failure_message_for_should do |target|
      "Expected #{target.class} to have an attribute '#{attr}'#{properties_to_sentence @extras}."
    end

    description do
      "have an attribute '#{attr}'#{properties_to_sentence @extras}."
    end
  end
end