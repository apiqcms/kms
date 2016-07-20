module Kms
  module Functions
    module Assets
      include ::Liquor::Library

      function "asset_tag", unnamed_arg: :string do |arg, kw|
        asset = Kms::Asset.where(file: arg).first
        case asset.try(:content_type)
        when "application/javascript" then "<script src=\"#{asset.file.url}\" type=\"text/javascript\" ></script>"
        when "text/css" then %{<link href="#{asset.file.url}" rel="stylesheet" type="text/css">}
        else ""
        end
      end

      function "asset_path", unnamed_arg: :string do |arg, kw|
        asset = Kms::Asset.where(file: arg).first
        if asset
          asset.file.url
        else
          arg
        end
      end

      # no ends_with in base liquor implementation
      function "ends_with", unnamed_arg: :string,
                            mandatory_named_args: { pattern: :string } do |arg, kw|
        arg.end_with?(kw[:pattern])
      end

      function "resize", unnamed_arg: :string, mandatory_named_args: { format: :string }  do |arg, kw|
        Dragonfly.app.fetch_url(arg).thumb(kw[:format]).url
      end

      function "add_watermark", unnamed_arg: :string, mandatory_named_args: { image: :string, dissolve: :string, position: :string }  do |arg, kw|
        Dragonfly.app.fetch_url(arg).add_watermark(kw[:image], kw[:dissolve], kw[:position]).url
      end

    end
  end
end
