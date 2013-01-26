require File.join(File.dirname(__FILE__), 'app.rb')

require 'rack/test'
require 'sinatra'
require 'rspec'

set :environment, :test

RSpec.configure do |config|
  DataMapper::setup(:default, Net::HTTP.get('api.postgression.com', '/'))
  config.before(:each) { DataMapper.auto_migrate! }
end

describe 'App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'creates a new user' do
    lambda do
      post '/new', params = { :email => 'postgression@gmail.com' }
    end.should {
      change(User, :count).by(1)
    }
  end
end
