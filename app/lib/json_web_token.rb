class JsonWebToken
  SECRET_KEY = ENV.fetch('SECRET_AUTH_KEY')

  def self.encode(payload, exp = 24.hours.from_now)
    # payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, {algorithm: 'HS256'})[0]
    HashWithIndifferentAccess.new decoded
  end
end