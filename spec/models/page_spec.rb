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

require 'rails_helper'

RSpec.describe Page, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
