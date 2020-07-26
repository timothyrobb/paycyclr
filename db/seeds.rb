# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Frequency.create(slug: :daily, name: "Daily", base_days: 1)
Frequency.create(slug: :weekly, name: "Weekly", base_days: 7)
Frequency.create(slug: :fortnightly, name: "Fortnightly", base_days: 14)
Frequency.create(slug: :monthly, name: "Monthly", base_days: -1)
