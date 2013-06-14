module Audit #TODO: Railstar
  module Transcribe
    extend ActiveSupport::Concern

    module ClassMethods
      def audit_log(force: false)
        has_many :audits, class_name: 'Audit::AuditLog', as: :auditable
        scope :auditable, -> { ::Audit::AuditLog.where(auditable_type: self) }
        if force
          after_create {|r| r.snapping(crud_name: 'create') }
          after_update {|r| r.snapping(crud_name: 'update') }
          before_destroy {|r| r.snapping(crud_name: 'delete') }
        end
      end

      def transcribe(user: nil, view_name: nil, action_name: nil, crud_name: 'search', acl: 'none', data: nil, opts: {})
        return false if !user
        ::Audit::AuditLog.create do |t|
          t.auditable_type = opts[:type]
          t.user_id = user.id
          t.view_name = view_name
          t.action_name = action_name
          t.crud_name = crud_name
          t.acl = acl
          t.data = data.to_json
        end
      end
    end

    def transcribe(user: nil, view_name: nil, action_name: nil, crud_name: nil, acl: 'none')
      return false if !user
      self.audits.create do |t|
        t.user_id = user.id
        t.view_name = view_name
        t.action_name = action_name
        t.crud_name = crud_name
        t.acl = acl
        t.data = self.to_json
      end
    end

    def snapping(crud_name: 'search')
      transcribe(user: self.user, view_name: 'none', action_name: 'snapshot', crud_name: crud_name)
    end
  end
end
