# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_planet_session',
  :secret      => '0af435ad812d7aef6973685a7c0dd8470c581b5227af48109c91b044bc9ccda6368c140cd5dbb310d43b63a7c62fdb12b5d93beaaca08e52a20d2d2a8bfbe7e0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
