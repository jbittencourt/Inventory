# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_inventory_session',
  :secret      => '0fe07fc309540bf15234bc767bba4bf444f85d50d6d382a54543e9007e468498f80bb216f90de7c7b649a5f0b6ed53cab91b8c3650b70f20d853e87ad5f97b61'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
