class RemoveFriendlyIdFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :friendly_id, :string
  end
end
