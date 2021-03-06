class Shop < ActiveRecord::Base
 attr_accessible :version 
 has_many :cached_products

  def self.find_by_url(url)
    shop = Shop.arel_table
    Shop.where(
      shop[:myshopify_domain].eq(url).
      or(
      shop[:domain].eq(url))
    ).first
  end

end
