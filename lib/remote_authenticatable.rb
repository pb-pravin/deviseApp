module Devise
  module Models
    module RemoteAuthenticatable
      extend ActiveSupport::Concern

      def remote_authentication(authentication_hash)
        # Your logic to authenticate with the external webservice
        return false if !authentication_hash or !authentication_hash[:user]

        # These four parameters are required by the authentication mechanism
        # id/password actually authenticate the user
        # org_id/term_id identify the remote server to perform auth against
        @id = authentication_hash[:user][:id]
        @org_id = authentication_hash[:user][:org_id]
        @term_id = authentication_hash[:user][:term_id]
        @password = authentication_hash[:user][:password]

        return false if @id.length > 3

        ret = false
        
        # Perform remote authentication here

        # The remote auth mechanism returns the user's display name
        # and access control list
        @name = "Display Name"
        @acl = "Access Control List"

        ret = @name != nil and @acl != nil
   
        return ret
      end
    end
  end
  
  module Strategies
    class RemoteAuthenticatable < Authenticatable
      def valid?
        true
      end
      
      #
      # For an example check : https://github.com/plataformatec/devise/blob/master/lib/devise/strategies/database_authenticatable.rb
      #
      # Method called by warden to authenticate a resource.
      #
      def authenticate!
        #
        # mapping.to is a wrapper over the resource model
        #
        resource = mapping.to.new

        return fail! unless resource

        # remote_authentication method is defined in Devise::Models::RemoteAuthenticatable
        #
        # validate is a method defined in Devise::Strategies::Authenticatable. It takes
        #a block which must return a boolean value.
        #
        # If the block returns true the resource will be logged in
        # If the block returns false the authentication will fail!
        #
        if validate(resource){ resource.remote_authentication(params) }
          success!(resource)
        end
      end
    end
  end
end
