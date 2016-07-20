require 'spec_helper'

describe Kms::HelpService, type: :service do
  it "should register help partials" do
    Kms::HelpService.register_templates Kms::Engine, 'kms_help.html'
    expect(Kms::HelpService.templates[Kms::Engine]).to include 'kms_help.html'
  end
end
