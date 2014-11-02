# Be sure to restart your server when you modify this file.

GeronimoSms::Application.config.session_store :cookie_store, 
	:key => '_my_session', 
	:expire_after => 2.minutes
