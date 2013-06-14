= Audit

## Instllation

Add this line to your application's Gemfile:

```ruby
  gem 'audit', github: 'runeleaf/audit'
```

Download and install by running:

```
> bundle install
```

### Generators

```
> rails g audit:migration
```

### Usage TODO:

```
> rails g audit:migration
> rake db:migrate
```

Model:

```ruby
class Post < ActiveRecord::Base
  audit_log
...
end
```

method:

```ruby
Post.transcribe user: current_user, view_name: 'test', action_name: 'posts#create', crud_name: 'search'
Post.auditable #=> [#<Audit::AuditLog>]
```

Callbacks:

```ruby
class Post < ActiveRecord::Base
  audit_log force: true
...
end
```

save or create:

```ruby
post = Post.new title: 'test'
post.save
post.audits #=> [#<Audit::AuditLog>]
```

update:

```ruby
post = Post.first
post.save
post.audits #=> [#<Audit::AuditLog>, #<Audit::AuditLog>]

post.transcribe user: current_user, view_name: 'test', action_name: 'posts#update', crud_name: 'update'
post.audits #=> [#<Audit::AuditLog>, #<Audit::AuditLog>, #<Audit::AuditLog>]
```

destroy:

```ruby
post = Post.first
post.destroy
post.audits #=> [#<Audit::AuditLog>, #<Audit::AuditLog>, #<Audit::AuditLog>, #<Audit::AuditLog>]
```

