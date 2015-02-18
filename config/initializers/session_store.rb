# Be sure to restart your server when you modify this file.

Rails.application.config.session_store :cookie_store, key: '_core_session',
                                                      expire_after: 30.days,
                                                      :secure => Rails.env == 'production', # Only send cookie over SSL when in production mode
                                                      :httponly => true
