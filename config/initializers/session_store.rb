# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_blog_demo_session',
  :secret      => 'aeea7a5454e1c36ebf9fb5da13ee95348b85198fe1d9ed63894f102683568a8ce69450a635ddc6c195025dcee1d7522ec3b4dfd2de49e517498710c52427dd75'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
