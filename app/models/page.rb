class Page
  include Mongoid::Document
  field :url, type: String
  field :s_url, type: String
end
