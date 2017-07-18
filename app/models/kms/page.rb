module Kms
  class Page < ActiveRecord::Base
    include Liquor::Dropable
    include CompileTemplates
    include Positioned

    INDEX_SLUG = 'index'.freeze
    INDEX_FULLPATH = ''
    NOT_FOUND_SLUG = '404'.freeze

    scope :published, lambda { where(published: true) }
    scope :listed, lambda { where(hidden: false) }
    scope :not_templatable, lambda { where(templatable: false) }

    belongs_to :template

    validates :slug, uniqueness: true, presence: true

    before_save :build_fullpath

    has_ancestry

    def self.not_found_page
      where(slug: NOT_FOUND_SLUG).first
    end

    def index?
      slug == INDEX_SLUG
    end

    def not_found?
      slug == NOT_FOUND_SLUG
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

    # fetch items for templatable page
    def fetch_items
      templatable_type.constantize.all
    end

    # fetch item by slug
    def fetch_item(slug)
      return nil unless templatable?
      templatable_type.constantize.find_by_slug(slug)
    end

  end
end
