module Kms
  module Functions
    module Currency
      include ::Liquor::Library

      function "currency",
                unnamed_arg: :string,
                optional_named_args: { precision: :integer,
                                       delimiter: :string,
                                       separator: :string,
                                       format:    :string,
                                       unit:      :string } do |arg, kw|
       options = {}
       [:precision, :delimiter, :separator, :format, :unit].each do |option|
           options[option] = kw[option] if kw[option]
       end
       ActiveSupport::NumberHelper.number_to_currency(arg, options)
      end
    end
  end
end
