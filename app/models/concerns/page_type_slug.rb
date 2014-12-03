module PageTypeSlug
  extend ActiveSupport::Concern

  included do
    after_save :sluggify_slug
  end

  def sluggify_slug
    unless title.blank?
      s = slug.blank? ? create_slug : clean_slug(slug)
      update_column(:slug, s) unless slug == s
      s
    end
  end

  def create_slug
    association = self.class.table_name.gsub(/^heartwood\_/, '')
    slug = clean_slug(self.title.downcase.gsub(/\&/, ' and '))
    dups = self.page_type.send(association).where(:slug => slug) - [self]
    slug = "#{slug}-#{self.id}" if dups.count > 0
    slug
  end

  def clean_slug(s)
    clean_slug = s.gsub(/[^a-zA-Z0-9 \-\_]/, "") # remove all bad characters
    clean_slug.gsub!(/\ /, "_") # replace spaces with underscores
    clean_slug.gsub!(/\_+/, "_") # replace repeating underscores
    clean_slug
  end

  def to_param
    slug
  end

end
