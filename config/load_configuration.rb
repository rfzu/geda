class DebugLogger < Logger
  def format_message(severity, timestamp, progname, message)
    message = message.try(:to_s)

    if message.nil?
      "NULL LOG MESSAGE\n"
    else
      "#{message.encode('UTF-8', invalid: :replace, replace: '')}\n"
    end
  rescue Exception => exc
    "EXCEPTION IN LOGGER! #{exc}\n"
  end
end

logfile1  = File.open(Rails.root.join('log', 'debug.log'), 'a')  #create log file
logfile2  = File.open(Rails.root.join('log', 'th.log'), 'a') 
logfile1.sync = true  #automatically flushes data to file
logfile2.sync = true
DEBUG_LOG = DebugLogger.new(logfile1)  #constant accessible anywhere

if Rails.env.production?
  DEBUG_LOG.level = 3 # error
end