module Kms
  module Permalinkable
    extend ActiveSupport::Concern

    # Entity should respond to "slug"
    def permalink
      templatable_page = Kms::Page.where(templatable_type: self.class.name).first
      if templatable_page
        Pathname.new(templatable_page.parent.fullpath).join(slug.to_s).to_s
      end
    end
  end
end
