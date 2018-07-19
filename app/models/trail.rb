class Trail < ActiveRecord::Base

validates_presence_of :name, :location
belongs_to :user



end
