class CreateAuditLogs < ActiveRecord::Migration
  def up
    create_table :audit_logs, force: true do |t|
      t.belongs_to :auditable, polymorphic: true
      t.integer :user_id
      t.string :acl
      t.string :view_name
      t.string :crud_name
      t.string :action_name
      t.text :data
      t.timestamps
    end

    # add_index
    add_index :audit_logs, :auditable_id
    add_index :audit_logs, :auditable_type
    add_index :audit_logs, :user_id

=begin # manually create view.
    execute <<-SQL
      drop view if exists reference_audit_logs
    SQL

    execute <<-SQL
      create view reference_audit_logs as
      select
        audit_logs.created_at as executable_at,
        branches.name as branch_name,
        homes.name as home_name,
        audit_logs.user_id as user_id,
        users.name as user_name,
        audit_logs.view_name as view_name,
        audit_logs.action_name as action_name,
        audit_logs.crud_name as crud_name,
        audit_logs.data as data
      from audit_logs
      left join users on users.id = audit_logs.user_id
      left join branches on branches.id = users.branch_id
      left join homes on homes.branch_id = branches.id
    SQL
=end

  end

  def down
    # remove_index
    drop_table :audit_logs
  end
end
