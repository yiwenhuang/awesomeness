class Technology < ApplicationRecord
  URL_REGEX = /\A(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/?.*)?$)\z/ix.freeze
  has_many :categories
  accepts_nested_attributes_for :categories

  validates_uniqueness_of :repo_url
  validates  :repo_url, format: { with: URL_REGEX, message: "Incorrect url format." }
end
