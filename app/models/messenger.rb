class Messenger
  def initialize 
    @connection = Twilio::REST::Client.new(ENV['twilio_account_sid'], ENV['twilio_auth_token'])
  end

  def self.send_text(to, body)
    @connection ||= Twilio::REST::Client.new(ENV['twilio_account_sid'], ENV['twilio_auth_token'])
    binding.pry
    @connection.account.messages.create({
      :from => '+15672986628',  
      :to => to,
      :body => body
    })
  end

end
