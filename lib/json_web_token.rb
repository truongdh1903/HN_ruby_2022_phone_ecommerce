class JsonWebToken
  SECRET_KEY = ENV["SECRET_KEY"]
  ALGORITHM = "HS256".freeze

  def self.encode payload, exp = 24.hours.from_now
    payload[:exp] = exp.to_i
    JWT.encode payload, SECRET_KEY, ALGORITHM
  end

  def self.decode token
    JWT.decode(token, SECRET_KEY, ALGORITHM)[0]
  end
end
