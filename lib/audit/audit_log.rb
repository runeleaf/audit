module Audit
  class AuditLog < ActiveRecord::Base
    validates :user_id, :view_name, :crud_name, :action_name, :acl, presence: true
    serialize :data
  end
end
