# http://www.devdaily.com/blog/post/ruby/read-web-service-ruby-client

# require 'soap/wsdlDriver'

# WSDL_URL = "http://localhost:8080/axis2/services/UserService?wsdl"
# factory = SOAP::WSDLDriverFactory.new(WSDL_URL)
# driver = factory.create_rpc_driver

# Soap Driver property protocol.http.proxy
# or driver.httpproxy = HTTP_PROXY=http://PROXY_USERNAME:PROXY_PASSW...@proxy.server.com:80
# ActionWebService::Client::Soap.new(PersonAPI, "http://...")

require 'net_http_client_patch'
require 'xmlrpc_client_patch'
require 'net/http'
module Revservice

  class Base
    attr_accessor :url, :key, :method_name, :params
    attr_reader :src_system_code, :results, :pref
  
    
    def initialize(api)
      @threads = []
      @resutls = {}
      @api = api
      @src_system_code = "RM"
      file_name = "#{RAILS_ROOT}/config/webservices.yml"
      @env = ENV['RAILS_ENV']
      if File.exists? file_name
        @pref = YAML.load_file(file_name)
        
      else
        raise "Cannot find config/webservices.yml to Load"
      end
      unless @pref.has_key? @env
        raise "No webservice config for #{@env}"      
      end
      
      @url = @pref[@env][@api.api_key]
    end
    
    # start the thread and call the webservice
    def call(m_name, *args) 
      @method_name = m_name
      @params = args
      finished = false
      attempt_count = 0
      proxy_url = build_proxy_url
      puts "Service URL\n\t#{@url}"
      puts "Proxy URL:\n\t#{proxy_url}"
      puts "\n\n"
      opts = {}
      #opts["protocol.http.basic_auth"] = [service_url, user_name, password]
      opts['protocol.http.proxy'] = proxy_url
      
      client = ActionWebService::Client::XmlRpc.new(@api, @url, :proxy => proxy_url)      
      args.insert(0, @key)
      args.insert(1, @src_system_code)
      while not finished
        begin
          attempt_count += 1
          if attempt_count > 3
            raise "Cannot communicate with server"
          end
          @results = client.send(@method_name.to_sym, *args)
          if @results
            finished = true
          end
        rescue Net::HTTPError => e
          puts e.response
          sleep 10
          raise 
        rescue Exception
          sleep 10
          raise 
        end
      end
      @results
    end
    
    private 
    def build_proxy_url
      user_name = @pref[@env]['proxy_user']
      host = @pref[@env]['proxy_host']
      port = @pref[@env]['proxy_port']
      password = @pref[@env]['proxy_password']
      protocol = @pref[@env]['proxy_protocol']
      # http://PROXY_USERNAME:PROXY_PASSW...@proxy.server.com:80
      if host.blank? or protocol.blank?
        raise Exception "Proxy Requires protocol and host"
      end
      proxy = ""
      proxy += "#{protocol}://"
      proxy += "#{user_name}" unless user_name.blank?
      proxy += ":#{password}" unless password.blank?
      proxy += "@" unless user_name.blank?
      proxy += "#{host}"
      proxy += ":#{port}"unless port.blank?
      proxy
      
    end
    
  
  end

end
