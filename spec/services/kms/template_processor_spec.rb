require 'spec_helper'

describe Kms::TemplateProcessor, type: :service do
  describe '#process' do
    let(:template) { FactoryGirl.build(:template) }
    subject { Kms::TemplateProcessor.new(template) }

    it "substitutes <script src> with {% ... asset_tag %}" do
      expect(subject.process).to include("{% 'compressed.js' | asset_tag %}")
    end

    it "substitutes <link rel='stylesheet'> with {% ... asset_tag %}" do
      expect(subject.process).to include("{% 'fonts.css' | asset_tag %}")
    end
  end
end
