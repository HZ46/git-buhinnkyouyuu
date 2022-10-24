# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(email: 'aaa.@jp', password: 'aaaaaa')

#if Rails.env.development?
 # Admin.create!(email: 'm.@jp', password: '111111')
  #(1..10).each do |n|
   # Department.create!(department_number: n, password: '111111')
  #end
#end

# User.create!(name: 'ゲスト', email: 'gest@sample.com')
# モデル名.create!(カラム名: 値)
#モデルクラス名.create(:カラム名1 => 値1, :カラム名2 => 値2, ...)
#admin.save!


# User.create!(name: 'ゲスト', email: 'gest@sample.com')
# モデル名.create!(カラム名: 値)
#モデルクラス名.create(:カラム名1 => 値1, :カラム名2 => 値2, ...)
#admin.save!
