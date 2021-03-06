# == Schema Information
#
# Table name: page_types
#
#  id             :integer          not null, primary key
#  site_id        :integer
#  title          :string(255)
#  slug           :string(255)
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#  page_templates :text
#  children       :text
#  label          :string(255)
#  order_by       :string(255)
#

class PageType < ActiveRecord::Base

  # ------------------------------------------ Plugins

  include SiteSlug

  # ------------------------------------------ Attributes

  attr_accessor :delete_group

  serialize :children, Array

  # ------------------------------------------ Associations

  belongs_to :site, :touch => true

  has_many :pages
  has_many :groups, :class_name => 'PageTypeFieldGroup', :dependent => :destroy
  has_many :fields, :class_name => 'PageTypeField', :through => :groups

  accepts_nested_attributes_for :groups
  accepts_nested_attributes_for :fields

  # ------------------------------------------ Scopes

  scope :alpha, -> { order('title asc') }

  # ------------------------------------------ Validations

  validates :title, :page_templates, :presence => true

  # ------------------------------------------ Callbacks

  after_save :remove_blank_groups

  def remove_blank_groups
    groups.where("title = ''").destroy_all
  end

  # ------------------------------------------ Instance Methods

  def templates
    page_templates.split("\n").reject(&:blank?).map { |t| t.strip }
  end

end
