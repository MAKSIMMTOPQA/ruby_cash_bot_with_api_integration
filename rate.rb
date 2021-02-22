require 'rest-client'

class Rate
  AVAILABLE_CURRENCIES = []
  API_URL = 'https://api.exchangeratesapi.io/'

  attr_accessor :hash_response, :currency_1_base, :currency_2_base, :rate

  def initialize(currency_1_base = nil, currency_2_base = nil)
    @currency_1_base = nil
    @currency_2_base = nil
  end

  def rate_url(param)
    @rate = "#{API_URL}latest?base=#{param}"
  end

  def rate_response
    @response_body ||= RestClient.get(@rate).body
    JSON(@response_body)
  end

  def specific_currency(currency)
    @response_body ||= RestClient.get(@rate).body
    @hash_response = JSON.parse(@response_body)['rates'].select { |element| element.to_s == currency }
  end 

  def parse_availbale_curencies
    available = "#{API_URL}latest?"
    @response_body ||= RestClient.get(available).body
    @hash_response = JSON.parse(@response_body)['rates'].keys
    AVAILABLE_CURRENCIES.push(@hash_response)
  end 
end

check = Rate.new.parse_availbale_curencies