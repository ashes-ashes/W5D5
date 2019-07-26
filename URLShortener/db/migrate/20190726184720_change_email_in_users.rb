class ChangeEmailInUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :email, :string, presence: true
  end
end
