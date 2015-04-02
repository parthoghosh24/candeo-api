threads 8,32
workers 2
bind  "unix:///opt/run/candeo_api.sock"
pidfile "tmp/pids/puma.pid"
state_path "tmp/pids/puma.state"
on_worker_boot do
	ActiveSupport.on_load(:active_record) do
    	ActiveRecord::Base.establish_connection
  	end
end