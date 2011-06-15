module Revservice #:nodoc:
  module Routing #:nodoc:
    module MapperExtensions
      def revservice
        @set.add_route("/reason_code_service/wsdl", {:controller=>"reason_code_service", :action =>"wsdl"} )
      end
    end
  end
end
 
ActionController::Routing::RouteSet::Mapper.send :include, Revservice::Routing::MapperExtensions
