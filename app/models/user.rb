class User < ActiveRecord::Base
  has_many :trails
  has_secure_password

end
