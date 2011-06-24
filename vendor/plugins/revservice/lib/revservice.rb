# Revservice

#require "revservice/routes"

%w{models services }.each do |dir|  #  controllers  helpers
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH << path
  ActiveSupport::Dependencies.load_paths << path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

require 'revservice/payer_encounter_helper'
require 'revservice/file_merge_helper'