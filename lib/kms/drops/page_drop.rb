module Kms
  class PageDrop < Liquor::Drop
    attributes :title, :slug, :fullpath, :published, :content, :listed, :templatable
    has_many :children
    belongs_to :parent
    export :breadcrumbs
    #export :children

    def children
      self.source.children.order("position").to_drop
    end

    def breadcrumbs
      parent = self.source
      breads = []
      while parent do
        breads << parent.to_drop
        parent = parent.parent
      end
      return breads.reverse
    end

  end
end
