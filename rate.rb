require 'rest-client'

class Rate
  AVAILABLE_CURRENCIES = []
  API_URL = 'https://api.exchangeratesapi.io/'

  attr_accessor :base, :hash_response

  def initialize(base = nil)
    @base = base
  end

  def weather_url(param)
    @weather = "#{API_URL}latest?base=#{param}"
  end

  def weather_response
    @response_body ||= RestClient.get(@weather).body
    JSON(@response_body)
  end

  def specific_currency(currency)
    @response_body ||= RestClient.get(@weather).body
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