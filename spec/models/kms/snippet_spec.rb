require 'spec_helper'

module Kms
  RSpec.describe Kms::Snippet, type: :model do
    it "should be registered via ResourceService" do
      expect(Kms::ResourceService.resources[:content_management][Kms::Snippet]).to_not be_nil
    end

    it "should be registered as Liquor partial" do
      snippet = FactoryGirl.create(:snippet)
      expect(Kms.template_manager.fetch_partial(snippet.register_id)).to_not be nil
    end
  end
end
