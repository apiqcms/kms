Liquor::Rails::Request.class_eval do
  delegate :base_url, :host, to: :@request
  export :base_url, :host
end
