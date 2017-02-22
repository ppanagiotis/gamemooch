template = ERB.new File.new("config/ldap.yml.erb").read
LDAP_CONFIG = YAML.load(template.result(binding))[Rails.env]
