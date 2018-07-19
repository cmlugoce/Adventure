class Trail < ActiveRecord::Base

validates_presence_of :name, :location, :date, :distance
belongs_to :user



end
