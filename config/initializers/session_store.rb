# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_ws_test_session',
  :secret      => 'e9189f648a9d5f8025ce1b670030472db070398aa3c11b7281907bfc6e73a1cddfe0877a09aa93ff1bd764d43913bbd73f4b2724d44148ebcc015393cd438134'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
