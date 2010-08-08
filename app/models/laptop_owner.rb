class LaptopOwner < ActiveRecord::Base
  belongs_to   :laptop
  belongs_to   :owner, :polymorphic => true
end
