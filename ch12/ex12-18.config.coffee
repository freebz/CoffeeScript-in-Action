# Listing 12.18  The blog application configuration file (config.coffee)

config =
  development:
    host: 'localhost'
    port: '8080'
  production:
    host: 'agtronsblog.com'
    port: '80'

for key, value of config
  exports[key] = value
