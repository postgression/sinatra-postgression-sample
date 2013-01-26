require 'sinatra'
require 'net/http'
require 'data_mapper'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String
end

configure :development do
  DataMapper::setup(:default, Net::HTTP.get('api.postgression.com', '/'))
  DataMapper.finalize.auto_upgrade!
end

get '/' do
  @users = User.all()
  @users.collect { |u| "#{u.email}<br/>" }
end

post '/new' do
  @user = User.create(params)
  "#{@user.email} created!"
end
