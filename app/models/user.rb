class User < ActiveRecord::Base
	has_many :user_times
	validates :name, :presence => true , :uniqueness => true 
	validates_format_of :name,  :with => /\A[a-zA-Z0-9]+[^\W]\z/

end
