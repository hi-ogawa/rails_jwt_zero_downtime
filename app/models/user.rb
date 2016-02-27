class User < ActiveRecord::Base
  validates :email, uniqueness: true

  def serialize
    {
      name: self.name,
      email: self.email
    }
  end

  def generate_token
    JWT.encode(self.serialize, SETTINGS["jwt_secret"], SETTINGS["jwt_algorithm"])
  end

  class << self

    def login(params)
      User.find_by(params)
    end

    # JWT based authentication
    def find_from_token(token)
      begin
        decoded_token = JWT.decode(token, SETTINGS["jwt_secret"], true, {algorithm: SETTINGS["jwt_algorithm"]})
        User.find_by(email: decoded_token[0]["email"])
      rescue JWT::DecodeError
        nil
      end
    end
  end
end
