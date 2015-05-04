if Rails.env.development?
	# scheduler = Rufus::Scheduler.new(:lockfile => ".rufus-scheduler.lock")
	#   var = "1s"
 #      unless scheduler.down?        
 #        scheduler.every var do
 #          #Job running every day at 8 am sending mails to ops.  
 #          puts "hi"
 #        end
 #      end
end

if Rails.env.production?
	scheduler = Rufus::Scheduler.new(:lockfile => ".rufus-scheduler.lock")	
	unless scheduler.down?        
        scheduler.every '7d' do
          # Queue refresh in every 7 days  
          ShowcaseTask.populate_performances
        end
    end
end

if Rails.env.staging?
	# scheduler = Rufus::Scheduler.new(:lockfile => ".rufus-scheduler.lock")
end	