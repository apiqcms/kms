require 'spec_helper'

describe Kms::Settings, type: :model do
  describe '.instance' do
    it 'returns an instance of Kms::Settings' do
      expect(Kms::Settings.instance).to be_a(Kms::Settings)
    end
  end
end
