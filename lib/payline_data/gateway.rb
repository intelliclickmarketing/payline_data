module PaylineData
  class Gateway
    class << self
      attr_accessor :username, :password
    end

    def add_customer(params)
      params   = credentials.merge(Customer.add(params))
      response = post(create_query(params))
    end

    def update_customer(params)
      params   = credentials.merge(Customer.update(params))
      response = post(create_query(params))
    end

    def delete_customer(params)
      data     = credentials.merge(Customer.delete(params))
      response = post(create_query(params))
    end

    def purchase(params)
      data     = credentials.merge(Transaction.sale(params))
      response = post(create_query(params))
    end

    private

    def credentials
      @credentials[:username] = username
      @credentials[:password] = password
    end

    def create_query(params)
      params.map { |k, v| "#{k}=#{v}" }.join('&')
    end

    def post(data)
      uri  = URI('https://secure.paylinedatagateway.com')
      http = Net::HTTP::Post.new(uri.host, uri.post)

      http.post('/api/transact.php', data)
    end
  end
end