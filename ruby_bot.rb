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
      @ruby_bot.session = true 
    when '/stop'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
      @ruby_bot.session = false 
      @ruby_bot.setuped_all = false 
      @ruby_bot.setuped_specific = false 
    when '/rate'
      bot.api.send_message(chat_id: message.chat.id, text: "Here you can see real-time rate for specific currency")
      bot.api.send_message(chat_id: message.chat.id, text: "Please type currency for which you want to see rate")
      @ruby_bot.setuped_all = false 
      @ruby_bot.setuped_specific = true 
      bot.api.send_message(chat_id: message.chat.id, text: "Setup currency_1")
      # unless @ruby_bot.cash
      #   bot.api.send_message(chat_id: message.chat.id, text: "Setup currency_1")
      # end
    when '/world' 
      bot.api.send_message(chat_id: message.chat.id, text: "Here you can see real-time rate for all currencies")
      bot.api.send_message(chat_id: message.chat.id, text: "Please type currency for which you want to see rate")
      @ruby_bot.setuped_all = true 
      @ruby_bot.setuped_specific = false 
      bot.api.send_message(chat_id: message.chat.id, text: "Setup your base currency")
      # unless @rate.currency_1_base
      #   bot.api.send_message(chat_id: message.chat.id, text: "Setup your base currency")
      #   @ruby_bot.cash = 0
      # end
      # if Rate::AVAILABLE_CURRENCIES.include?(@rate.base)
      #   @rate.weather_url(@rate.base)
      #   bot.api.send_message(chat_id: message.chat.id, text: "#{@rate.weather_response}")
      # else 
      #   bot.api.send_message(chat_id: message.chat.id, text: "Please select from available currencies")
      #   bot.api.send_message(chat_id: message.chat.id, text: "Available currencies")
      #   bot.api.send_message(chat_id: message.chat.id, text: "#{@rate.parse_availbale_curencies}")
      # end 
    when '/all'
      bot.api.send_message(chat_id: message.chat.id, text: "Available currencies")
      bot.api.send_message(chat_id: message.chat.id, text: "#{@rate.parse_availbale_curencies}")
    else 
      if @ruby_bot.setuped_all == true 
        @rate.currency_1_base = message.text 
        @rate.currency_1_base.to_s
        # if Rate::AVAILABLE_CURRENCIES.include?(@rate.currency_1_base)
          @rate.rate_url(@rate.currency_1_base)
          puts @rate.rate
          bot.api.send_message(chat_id: message.chat.id, text: "Your base currency, #{@rate.currency_1_base}")
          bot.api.send_message(chat_id: message.chat.id, text: "Response #{@rate.rate_response}")
          @ruby_bot.setuped_all = false
          @rate.currency_1_base = nil
        # else
        #   bot.api.send_message(chat_id: message.chat.id, text: "Please select from available currencies")
        #   bot.api.send_message(chat_id: message.chat.id, text: "Available currencies")
        #   bot.api.send_message(chat_id: message.chat.id, text: "#{@rate.parse_availbale_curencies}")
        # end 
      elsif @ruby_bot.setuped_specific == true 
        if !@rate.currency_2_base
          @rate.currency_2_base = message.text 
          bot.api.send_message(chat_id: message.chat.id, text: "Your setuped you currency #{@rate.currency_2_base}")
          bot.api.send_message(chat_id: message.chat.id, text: "Know please select base exchange currency")
        elsif !@rate.currency_1_base
          @rate.currency_1_base = message.text 
          @rate.currency_1_base.to_s
          @rate.rate_url(@rate.currency_1_base)
          bot.api.send_message(chat_id: message.chat.id, text: "Your base currency, #{@rate.currency_1_base}")
          bot.api.send_message(chat_id: message.chat.id, text: "Response #{@rate.specific_currency(@rate.currency_2_base)}")
        end  
        @ruby_bot.setuped_specific = false 
        @rate.currency_1_base = nil
        @rate.currency_2_base = nil
      else 
        bot.api.send_message(chat_id: message.chat.id, text: "Invalid event")
      end
    end
  end
end