class Messenger

  def self.send_code(to, code)
    connection ||= Twilio::REST::Client.new(ENV['twilio_account_sid'], ENV['twilio_auth_token'])
    connection.account.messages.create({
      :from => '+15672986628',  
      :to => "+1#{to}",
      :body => "Your confimation number is #{code}. Please continue on our mobile website."
    })
  end

  def self.send_quote(to, quote)
    connection ||= Twilio::REST::Client.new(ENV['twilio_account_sid'], ENV['twilio_auth_token'])
    connection.account.messages.create({
      :from => '+15672986628',  
      :to => "+1#{to}",
      :body => "Your vehicle will be ready in #{quote} minutes. Please try to be on time!"
    })
  end

end
