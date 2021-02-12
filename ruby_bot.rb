require 'telegram/bot'
require_relative "./exchange"
require_relative "./rate"
require 'yaml'

token = YAML.load_file('token.yaml')
Telegram::Bot::Client.run(token) do |bot|
  @ruby_bot ||= Exchange.new
  @rate ||= Rate.new 

  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}")
      bot.api.send_message(chat_id: message.chat.id, text: "Welcome to currency rates bot, where you can see rate for specific or all available currencies")
      bot.api.send_message(chat_id: message.chat.id, text: "Available options")
      bot.api.send_message(chat_id: message.chat.id, text: "/rate (specific currency), /all (available currencies), /world (world currencies rate)")
      # bot.api.send_message(chat_id: message.chat.id, text: "Type in currency, exchange rate")
      @ruby_bot.session = true 
      @ruby_bot.cash = false
      @rate.base = false 
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
      @ruby_bot.session = false 
    when '/rate'
      bot.api.send_message(chat_id: message.chat.id, text: "Here you can see real-time rate for specific currency")
      bot.api.send_message(chat_id: message.chat.id, text: "Please type currency for which you want to see rate")
      unless @ruby_bot.cash
        bot.api.send_message(chat_id: message.chat.id, text: "Setup currency_1")
      end
        # @ruby_bot.set_currency = false 
        # if @ruby_bot.set_currency 
        #   @ruby_bot.cash = message.text 
        #   bot.api.send_message(chat_id: message.chat.id, text: "Your setuped you currency #{@ruby_bot.cash}")
        #   bot.api.send_message(chat_id: message.chat.id, text: "Know please currency for which you wanna to convert the rate")
        #   @ruby_bot.set_currency = true 
        # else
        #   @rate.base = message.text
        #   @rate.base.to_s
        #   @rate.weather_url(@rate.base)
        #   bot.api.send_message(chat_id: message.chat.id, text: "Your base currency, #{@rate.base}")
        #   # bot.api.send_message(chat_id: message.chat.id, text: "Response #{@rate.weather_response}")
        #   bot.api.send_message(chat_id: message.chat.id, text: "Response #{@rate.specific_currency(@ruby_bot.cash)}")
        #   # @rate.specific_currency(@ruby_bot.cash)
        #   bot.api.send_message(chat_id: message.chat.id, text: "Response #{@rate.hash_response}")
        #   @ruby_bot.set_currency = false 
        # end
    when '/world' 
      bot.api.send_message(chat_id: message.chat.id, text: "Here you can see real-time rate for all currencies")
      bot.api.send_message(chat_id: message.chat.id, text: "Please type currency for which you want to see rate")
      @rate.base = message.text
      @rate.base.to_s.upcase
      if Rate::AVAILABLE_CURRENCIES.include?(@rate.base)
        @rate.weather_url(@rate.base)
        bot.api.send_message(chat_id: message.chat.id, text: "#{@rate.weather_response}")
      else 
        bot.api.send_message(chat_id: message.chat.id, text: "Please select from available currencies")
        bot.api.send_message(chat_id: message.chat.id, text: "Available currencies")
        bot.api.send_message(chat_id: message.chat.id, text: "#{@rate.parse_availbale_curencies}")
      end 
    when '/all'
      bot.api.send_message(chat_id: message.chat.id, text: "Available currencies")
      bot.api.send_message(chat_id: message.chat.id, text: "#{@rate.parse_availbale_curencies}")
    else 
      if !@ruby_bot.cash
        @ruby_bot.cash = message.text 
        bot.api.send_message(chat_id: message.chat.id, text: "Your setuped you currency #{@ruby_bot.cash}")
        bot.api.send_message(chat_id: message.chat.id, text: "Know please select base exchange currency")
      elsif !@rate.base
        @rate.base = message.text 
        @rate.base.to_s
        @rate.weather_url(@rate.base)
        bot.api.send_message(chat_id: message.chat.id, text: "Your base currency, #{@rate.base}")
      #   bot.api.send_message(chat_id: message.chat.id, text: "Response #{@rate.weather_response}")
        bot.api.send_message(chat_id: message.chat.id, text: "Response #{@rate.specific_currency(@ruby_bot.cash)}")
      #   bot.api.send_message(chat_id: message.chat.id, text: "Response #{@rate.hash_response}")
      else 
        bot.api.send_message(chat_id: message.chat.id, text: "Invalid event")
      end
      # if @ruby_bot.set_currency == false 
      #   @ruby_bot.cash = message.text 
      #   bot.api.send_message(chat_id: message.chat.id, text: "Your setuped you currency #{@ruby_bot.cash}")
      #   bot.api.send_message(chat_id: message.chat.id, text: "Know please select base exchange currency")
      #   @ruby_bot.set_currency = true 
      # elsif @ruby_bot.set_currency == true
      #   @rate.base = message.text
      #   @rate.base.to_s
      #   @rate.weather_url(@rate.base)
      #   bot.api.send_message(chat_id: message.chat.id, text: "Your base currency, #{@rate.base}")
      #   # bot.api.send_message(chat_id: message.chat.id, text: "Response #{@rate.weather_response}")
      #   bot.api.send_message(chat_id: message.chat.id, text: "Response #{@rate.specific_currency(@ruby_bot.cash)}")
      #   bot.api.send_message(chat_id: message.chat.id, text: "Response #{@rate.hash_response}")
      #   @ruby_bot.set_currency = false 
      # end
    end
  end
end