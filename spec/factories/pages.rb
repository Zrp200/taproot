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

FactoryGirl.define do
  factory :page do
    page_type_id 1
title "MyString"
slug "MyString"
description "MyText"
body "MyText"
ancestry "MyString"
published false
field_data "MyText"
  end

end
