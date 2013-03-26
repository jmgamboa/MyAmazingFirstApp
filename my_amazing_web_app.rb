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


  if params[:answer] && params[:tc] == "1" 
    
    @message = "#{params[:firstname]} drinks their coffee #{params[:answer]}"
    
    
    @account_sid = "ACf5043ffa0a4bbfccf4e9ac9859db2f35"
    @auth_token = "7e18c038d8aab03ee080eb399423a2bc"
  
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
      
    @account = @client.account
    @sms = @account.sms.messages.create({
      :from => '+13472526388', 
      :to => '+19089303419',
      :body => @message
    })
    
    flash[:notice] = "SMS sent: #{@message}"
    redirect '/'
     
  else

    flash[:notice] = "Please check the appropriate boxes"
    redirect '/'

  end

   
end
