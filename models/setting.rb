class Setting < ActiveRecord::Base
  validates_presence_of :key, :value
end
