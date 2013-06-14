class Post < ActiveRecord::Base
  audit_log

  belongs_to :user
end

class Comment < ActiveRecord::Base
  audit_log force: true

  belongs_to :user
end

class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  belongs_to :branch
end

class Branch < ActiveRecord::Base
  has_many :users
end

class Home < ActiveRecord::Base
  belongs_to :branch
end
