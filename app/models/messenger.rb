class Messenger

  def self.send_code(to, code)
    @connection ||= Twilio::REST::Client.new(ENV['twilio_account_sid'], ENV['twilio_auth_token'])
    @connection.account.messages.create({
      :from => '+15672986628',  
      :to => to,
      :body => code
    })
  end

  def self.send_quote(to, quote)
    @connection ||= Twilio::REST::Client.new(ENV['twilio_account_sid'], ENV['twilio_auth_token'])
    @connection.account.messages.create({
      :from => '+15672986628',  
      :to => to,
      :body => quote
    })
  end

end
