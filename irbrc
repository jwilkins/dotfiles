
begin
#require 'utility_belt'
rescue LoadError
end
require 'irb/completion'
IRB.conf[:AUTO_INDENT]=true

require 'irb/ext/save-history'
IRB.conf[:SAVE_HISTORY] = 100
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb-save-history"
