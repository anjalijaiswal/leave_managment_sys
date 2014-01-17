class User < ActiveRecord::Base
	has_many :user_times , dependent: :destroy
	validates :name, :presence => true , :uniqueness => true ,length: { maximum: 10 }
	validates_format_of :name,  :with => /\A[a-zA-Z0-9]+[^\W]\z/

end
