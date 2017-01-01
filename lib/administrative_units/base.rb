require 'httparty'

module AdministrativeUnits
  class Base
    include HTTParty
    format :json

    def initialize
      super
    end

    def request(path, options={})
      HTTParty.get(base_uri + path, options)
    end

    def import
      raise 'You have to override it!'
    end

    def base_uri
      raise 'You have to specific base uri'
    end

    def stand_for(string)
      return if string.blank?
      string.split.map(&:chr).join.downcase
    end
  end
end

