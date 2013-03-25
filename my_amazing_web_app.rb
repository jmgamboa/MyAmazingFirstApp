require 'twilio-ruby'
require 'sinatra'
require 'rack-flash'

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

get '/' do
  erb :index
end

post '/submit' do
  @message = "Someone thought your image was #{params[:answer]}"
  
  # Change these to match your Twilio account settings 
  @account_sid = "ACf5043ffa0a4bbfccf4e9ac9859db2f35"
  @auth_token = "7e18c038d8aab03ee080eb399423a2bc"
  
  # Set up a client to talk to the Twilio REST API
  @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    
  @account = @client.account
  @sms = @account.sms.messages.create({
    :from => '3479832456', 
    :to => '+9089303419',
    :body => @message
  })
  
  flash[:notice] = "SMS sent: #{@message}"
  redirect '/'
end
