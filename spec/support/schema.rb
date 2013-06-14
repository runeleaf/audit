
require(File.expand_path("../../../lib/generators/audit/templates/migration.rb", __FILE__))

ActiveRecord::Schema.define :version => 0 do

  create_table :posts, force: true do |t|
    t.belongs_to :user
    t.string :title
    t.text :body
    t.timestamp
  end

  create_table :comments, force: true do |t|
    t.belongs_to :user
    t.string :description
    t.timestamp
  end

  create_table :branches, force: true do |t|
    t.string :name
  end

  create_table :users, force: true do |t|
    t.belongs_to :branch
    t.string :name
  end

  create_table :homes, force: true do |t|
    t.belongs_to :branch
    t.string :name
  end

  b = Branch.create(name: 'branch1')
  h = Home.create(name: 'home1', branch_id: b.id)
  u1 = User.create(name: 'user1', branch_id: b.id)
  u2 = User.create(name: 'user2', branch_id: b.id)

  Post.create(title: 'aaa', body: 'bbb', user_id: u1.id)
  Post.create(title: 'ccc', body: 'ddd', user_id: u1.id)

end

CreateAuditLogs.migrate(:up)


