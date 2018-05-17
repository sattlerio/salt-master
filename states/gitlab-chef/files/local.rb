module OmniAuth
  module Strategies
    class LDAP
      class << self
        alias_method :map_user_orig, :map_user
      end

      def self.map_user(mapper, object)
        object['mail'] += ["#{object['uid'].first}"]
        self.map_user_orig(mapper, object)
      end
    end
  end
end
