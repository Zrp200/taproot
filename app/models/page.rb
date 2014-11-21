# == Schema Information
#
# Table name: pages
#
#  id           :integer          not null, primary key
#  page_type_id :integer
#  title        :string(255)
#  slug         :string(255)
#  description  :text
#  body         :text
#  ancestry     :string(255)
#  published    :boolean          default(FALSE)
#  field_data   :text
#  created_at   :datetime
#  updated_at   :datetime
#  position     :integer          default(0)
#  template     :string(255)
#  order        :string(255)
#

class Page < ActiveRecord::Base

  # ------------------------------------------ Plugins

  include PageTypeSlug

  has_ancestry

  # ------------------------------------------ Attributes

  serialize :field_data, Hash

  # ------------------------------------------ Associations

  belongs_to :page_type, :touch => true

  has_many :page_images
  has_many :images, :through => :page_images

  has_one :site, :through => :page_type

  # ------------------------------------------ Scopes

  scope :in_position, -> { order('position asc') }
  scope :published, -> { where(:published => true) }

  # ------------------------------------------ Validations

  validates :title, :template, :presence => true

  def respond_to_fields
    field_data.keys
  end

  def method_missing(method, *arguments, &block)
    begin
      super
    rescue
      if respond_to_fields.include?(method.to_s)
        if method.to_s =~ /image/
          Image.find_by_idx(field_data[method.to_s]).image
        else
          field_data[method.to_s]
        end
      else
        super
      end
    end
  end

  def respond_to?(method, include_private = false)
    begin
      super
    rescue
      respond_to_fields.include?(method.to_s) ? true : false
    end
  end

end
