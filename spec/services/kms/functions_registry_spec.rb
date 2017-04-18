require 'spec_helper'

describe Kms::FunctionsRegistry, type: :service do
  it 'should contain default functions' do
    expect(Kms::FunctionsRegistry.modules).to contain_exactly(Liquor::Pagination, Kms::Functions::Assets, Kms::Functions::Currency)
  end
  describe '.register' do
    it "should register modules with liquor functions" do
      NewModule = Module.new { include ::Liquor::Library }
      Kms::FunctionsRegistry.register NewModule
      expect(Kms::FunctionsRegistry.modules).to include NewModule
    end
  end
end
