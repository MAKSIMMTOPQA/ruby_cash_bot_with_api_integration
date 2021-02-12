class Exchange
    attr_accessor :cash, :exchange_cash, :session, :set_currency, :currency_1, :currency_2
    CASH_TABLE = ['usd', 'uah']
    EXCHANGE_USD_TABLE = { 'usd' => 29, 'ddd' => 29, 'uah' => 28 }

    def initialize(cash = nil, exchange_cash = nil)
        @cash = cash
        @exchange_cash = exchange_cash
        @session = false 
        @set_currency = false 
    end

    # def setup_cash(new_cash)
    #   new_cash.to_s
    #   if CASH_TABLE.include?(new_cash.to_s)
    #     @cash = new_cash
    #     @cash.to_s
    #     if EXCHANGE_USD_TABLE.key?(@cash)
    #       puts EXCHANGE_USD_TABLE.assoc(@cash)
    #       # EXCHANGE_USD_TABLE["#{@cash}"].each do |key, value.to_s|
    #       #   puts key.to_s + ' : ' + value.to_s
    #       # end 
    #       # EXCHANGE_USD_TABLE.each do |key, value|
    #       #   puts key.to_s + ' : ' + value.to_s
    #       # end 
    #     else 
    #       puts 'hash'
    #     end 
    #   else 
    #     puts 'invalid'
    #   end 
    # end 
    # @ruby_bot.cash = message.text 
      # bot.api.send_message(chat_id: message.chat.id, text: "Your currency is #{@ruby_bot.cash}")
      # bot.api.send_message(chat_id: message.chat.id, text: "The rate is #{@rate.weather_response}")
      # bot.api.send_message(chat_id: message.chat.id, text: "Your currency is #{@ruby_bot.cash}")
      # if Exchange::CASH_TABLE.include?(@ruby_bot.cash.to_s)
      #   if Exchange::EXCHANGE_USD_TABLE.key?(@ruby_bot.cash)
      #     bot.api.send_message(chat_id: message.chat.id, text: "The rate is #{Exchange::EXCHANGE_USD_TABLE.assoc(@ruby_bot.cash)}")
      #     bot.api.send_message(chat_id: message.chat.id, text: "The rate is #{@rate.weather_response}")
      #   else 
      #     bot.api.send_message(chat_id: message.chat.id, text: "error")
      #   end 
      # else 
      #   bot.api.send_message(chat_id: message.chat.id, text: "error")
      # end 
    # end 
end