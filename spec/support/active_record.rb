require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Migration.create_table :cars do |t|
  t.string :make
  t.string :model
end

ActiveRecord::Migration.create_table :doors do |t|
  t.references  :car
  t.string      :position
end

# :nodoc:
class Car < ActiveRecord::Base
  has_many :doors, autosave: true
end

# :nodoc:
class Door < ActiveRecord::Base
  belongs_to :car

  validates_inclusion_of :position, in: %w(left right)
end
