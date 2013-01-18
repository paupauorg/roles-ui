# This migration comes from roles_ui_engine (originally 20121001112004)
class RolesUiCreateRoles < ActiveRecord::Migration
  def change
    # roles
    create_table(:roles) do |t|
      t.string :name
      t.timestamps
    end
    add_index(:roles, :name)

    # permissions
    create_table(:permissions) do |t|
      t.references :role
      t.string :name
      t.string :resource
      t.string :condition
      t.boolean :cannot
      t.integer :priority

      t.timestamps
    end
    add_index(:permissions, :name)
    add_index(:permissions, [ :role_id, :name ])

    # assignments
    create_table(:assignments) do |t|
      t.references :localuser, :polymorphic => true
      t.references :role
    end
    add_index(:assignments, [ :localuser_id, :localuser_type ])
  end
end
