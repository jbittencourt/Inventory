class AddPictureLaptopModel < ActiveRecord::Migration
  def self.up
    add_column :laptop_models, :picture_file_name,    :string
    add_column :laptop_models, :picture_content_type, :string
    add_column :laptop_models, :picture_file_size,    :integer
    add_column :laptop_models, :picture_updated_at,   :datetime
  end

  def self.down
  end
end
