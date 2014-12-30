Rack::Timeout.timeout = (ENV["RACK_TIMEOUT"] || 10).to_i
Rack::Timeout.unregister_state_change_observer(:logger)
