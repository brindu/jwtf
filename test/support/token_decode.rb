require 'base64'

module JWTF::Test
  module TokenDecode
    def jwt_payload(jwt)
      base64_payload = jwt.split('.')[1]
      payload = Base64.urlsafe_decode64(base64_payload)
      JSON.parse(payload, symbolize_names: true)
    end
  end
end
