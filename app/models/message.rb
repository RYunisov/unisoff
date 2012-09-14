class Message < ActiveRecord::Base
  attr_accessible :message, :to

  belongs_to :user
end
