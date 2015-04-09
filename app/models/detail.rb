class Detail < ActiveRecord::Base
  belongs_to :route
  validates :stop_number, :uniqueness => { :scope => :stop_name }
end
