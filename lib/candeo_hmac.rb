class CandeoHmac

	def self.generate_hmac(secret, message)	   
       hash = OpenSSL::HMAC.digest('sha256',secret,message)
       auth_token=Base64.encode64(hash).tr('+/=1TO0','pqrsxyz')       
       auth_token
	end
end