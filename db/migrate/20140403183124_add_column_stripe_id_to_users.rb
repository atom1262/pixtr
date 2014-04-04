class AddColumnStripeIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_id, :string, default: ""
  end
end
