# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = Admin.create!(:email => 'admin.com', :encrypted_password => '114466')
# User.create!(name: 'ゲスト', email: 'gest@sample.com')
# モデル名.create!(カラム名: 値)
admin.save!
