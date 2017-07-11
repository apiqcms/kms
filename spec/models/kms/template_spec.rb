require 'spec_helper'

module Kms
  describe Kms::Template, type: :model do
    it "should be registered via ResourceService" do
      expect(Kms::ResourceService.resources[:content_management][Kms::Template]).to_not be_nil
    end

    it "should be registered as Liquor template" do
      template = FactoryGirl.create(:template)
      expect(Kms.template_manager.instance_variable_get("@templates")[template.register_id]).to_not be nil
    end

  end
end
