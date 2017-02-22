module Devise
  module Strategies
    class LdapAuthenticatable < Authenticatable

      def new_connection
        ldap_options = {}
        ldap_options[:encryption] = :simple_tls if LDAP_CONFIG["ssl"]
        ldap      = Net::LDAP.new(ldap_options)
        ldap.host = LDAP_CONFIG['host']
        ldap.port = LDAP_CONFIG['port']
        ldap
      end

      def authenticate!
        if params[:user]
          user = User.where(email: mail).first
          if user
            if user.valid_password?(password)
              success!(user)
            end
          elsif
            conn = new_connection
            user = fetch_user(mail)
            if user
              conn.auth user.dn, password
              if conn.bind
                username = user.uid
                first_name = user.givenName
                last_name = user.sn
                user = User.find_or_create_by(email: mail) do |user|
                  user.password = password
                  user.provider = 'ldap'
                  user.username = username[0]
                  user.first_name = first_name[0]
                  user.last_name = last_name[0]
                end
                success!(user)
              end
            end
          else
            return fail(:invalid_login)
          end
        end
      end

      def mail
        params[:user][:login]
      end

      def passwor
        params[:user][:password]
      end

      def fetch_user(mail)
        conn = new_connection
        base   = LDAP_CONFIG['base']
        attribute = LDAP_CONFIG['attribute']
        filter = Net::LDAP::Filter.eq(attribute, mail)
        params = {:base => base, :filter => filter}
        res = conn.search(params)
        res ? res.first : nil
      end
    end
  end
end

Warden::Strategies.add(:ldap_authenticatable, Devise::Strategies::LdapAuthenticatable)
