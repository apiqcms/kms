module Kms
  class Page < ActiveRecord::Base
    include Liquor::Dropable
    include CompileTemplates

    INDEX_SLUG = "index"
    INDEX_FULLPATH = ""

    scope :published, lambda { where(published: true) }
    scope :listed, lambda { where(hidden: false) }
    scope :not_templatable, lambda { where(templatable: false) }

    belongs_to :template

    validates :slug, uniqueness: true, presence: true

    before_save :build_fullpath

    before_create :set_position

    has_ancestry

    def index?
      slug == INDEX_SLUG
    end

    def build_fullpath
      if index?
        self.fullpath = INDEX_FULLPATH # self.slug
      else
        slugs = (ancestors + [self]).map(&:slug)
        slugs.shift unless slugs.size == 1
        self.fullpath = File.join slugs.compact
      end
    end

    def set_position
      if parent.present?
        max = parent.children.maximum(:position)
      else
        max = Page.where('ancestry IS ?', nil).maximum(:position)
      end
      self.position = max ? max + 1 : 0
    end

    # fetch items for templatable page
    def fetch_items
      templatable_type.constantize.all
    end

    # fetch item by slug
    def fetch_item!(slug)
      return nil unless templatable?
      templatable_type.constantize.find_by_slug!(slug)
    end

  end
end
