ActiveRecord::Base.establish_connection({
  :adapter  => 'sqlite3',
  #:database => ':memory:'
  :database => File.dirname(__FILE__) + "/test.sqlite3"
})
