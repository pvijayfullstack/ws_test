# Revservice

#require "revservice/routes"

%w{models services }.each_with_index do |dir, index|  #  controllers  helpers
  path = File.join(File.dirname(__FILE__), 'app', dir)
  $LOAD_PATH.insert index, path
  ActiveSupport::Dependencies.load_paths.insert index, path
  ActiveSupport::Dependencies.load_once_paths.delete(path)
end

require 'revservice/payer_encounter_helper'
require 'revservice/file_merge_helper'