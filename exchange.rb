class Exchange
    attr_accessor :cash, :exchange_cash, :session, :set_currency, :currency_1, :currency_2, :setuped_specific, :setuped_all
    CASH_TABLE = ['usd', 'uah']
    EXCHANGE_USD_TABLE = { 'usd' => 29, 'ddd' => 29, 'uah' => 28 }

    def initialize(session = false, setuped_all = false, setuped_specific = false)
        @setuped_specific = false
        @setuped_all = false 
        @session = false 
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
end