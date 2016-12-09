module Kms
  class Asset < ActiveRecord::Base
    include UpdateStylesheetsText

    mount_uploader :file, AssetUploader

    # inspired by Locomotive
    before_validation :store_text

    validate :unique_filename, on: :create

    attr_accessor :text, :performing_plain_text

    def filename
      read_attribute(:file)
    end

    def url
      file.url
    end

    def text
      @text ||= (file.read.force_encoding('UTF-8') rescue nil)
    end

    alias :content :text

    def performing_plain_text?
      performing_plain_text
    end

    def stylesheet_or_javascript?
      stylesheet? || javascript?
    end

    def text_or_javascript?
      text_type? || javascript?
    end

    def stylesheet?
      content_type.include?("css")
    end

    def javascript?
      content_type.include?("javascript")
    end

    def text_type?
      content_type.start_with?("text")
    end

    def store_text
      return if persisted? && !text_or_javascript?

      data = performing_plain_text? ? text : (file.present? ? file.read : nil)

      return if !text_or_javascript? || data.blank?

      sanitized_source = replace_urls(data)

      self.file = ::CarrierWave::SanitizedFile.new({
        tempfile: StringIO.new(sanitized_source),
        filename: filename || file.filename
      })

      @text = sanitized_source
    end

    protected

    def unique_filename
      if Asset.where(file: file.filename).exists?
        self.errors.add(:file, "is duplicate")
      end
    end

    def replace_urls(text)
      return if text.blank?

      text.gsub(/url\((.+)\)/) do |path|
        asset_name = $1.split("/")[-1]

        if asset = Asset.where(file: asset_name.gsub(/['"]/, '')).first
          "url(#{asset.file.url})"
        else
          path
        end
      end
    end
  end
end
