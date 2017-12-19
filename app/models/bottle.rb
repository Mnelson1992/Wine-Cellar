class Bottle < ActiveRecord::Base
  belongs_to :user

  validates :name, :location, :year, :grape, presence: true
end
