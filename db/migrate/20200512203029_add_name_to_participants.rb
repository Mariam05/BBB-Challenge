class AddNameToParticipants < ActiveRecord::Migration[6.0]
  def change
    add_column :participants, :name, :string
  end
end
