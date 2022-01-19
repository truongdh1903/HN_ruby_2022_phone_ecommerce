class Message < ApplicationRecord
  belongs_to :user_sender, class_name: User.name
  belongs_to :user_receiver, class_name: User.name
end
