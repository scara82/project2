require "active_record"

options = {
  adapter: 'postgresql',
  database: 'currency_swap'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
