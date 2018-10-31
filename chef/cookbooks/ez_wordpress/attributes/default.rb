def generate_code(number)
  charset = (0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a + "!@#$%^&*()".split('').to_a
  Array.new(number-1) { charset.sample }.join
end

default['wordpress']['keys']['auth'] = generate_code(64)
default['wordpress']['keys']['secure_auth'] = generate_code(64)
default['wordpress']['keys']['logged_in'] = generate_code(64)
default['wordpress']['keys']['nonce'] = generate_code(64)
default['wordpress']['salt']['auth'] = generate_code(64)
default['wordpress']['salt']['secure_auth'] = generate_code(64)
default['wordpress']['salt']['logged_in'] = generate_code(64)
default['wordpress']['salt']['nonce'] = generate_code(64)

default['wordpress']['db']['name'] = 'wordpress'
default['wordpress']['db']['user'] = 'wordpress'
default['wordpress']['db']['pass'] = 'wordpress'

default['wordpress']['server_name'] = node['fqdn']
default['wordpress']['dir'] = "/var/www/wordpress"
default['wordpress']['url'] = 'https://wordpress.org/latest.tar.gz'




# default['wordpress']['server_aliases'] = [node['fqdn']]
