require "xmlrpc/client"
require 'net/http'

module XMLRPC

  class Client
    
    def create_http_with_proxy_auth(proxy_user, proxy_pass)
      puts "Creating http proxy with auth for #{proxy_user}"
      @http = Net::HTTP::Proxy(@proxy_host, @proxy_port, proxy_user, proxy_pass).new(@host, @port)
      #@http = Net::HTTP.new(@host, @port, @proxy_host, @proxy_port) 
      @http.use_ssl = @use_ssl if @use_ssl
      @http.read_timeout = @timeout
      @http.open_timeout = @timeout

      @http
    end
    class << self

      def new2(uri, proxy=nil, timeout=nil)
        if match = /^([^:]+):\/\/(([^@]+)@)?([^\/]+)(\/.*)?$/.match(uri)
          proto = match[1]
          user, passwd = (match[3] || "").split(":")
          host, port = match[4].split(":") 
          path = match[5]
  
          if proto != "http" and proto != "https"
            raise "Wrong protocol specified. Only http or https allowed!"
          end
  
        else
          raise "Wrong URI as parameter!"
        end
   
        #proxy_host, proxy_port = (proxy || "").split(":")
        unless proxy.nil?
          proxy = URI.parse(proxy)
          proxy_host = proxy.host
          proxy_port = proxy.port
          unless proxy.userinfo.nil? or proxy.userinfo == ""
            proxy_auth = true
            proxy_user = proxy.userinfo.split(":")[0]
            proxy_pass = proxy.userinfo.split(":")[1] 
          end
        end
  
        client = self.new(host, path, port, proxy_host, proxy_port, user, passwd, (proto == "https"), timeout)
        client.create_http_with_proxy_auth(proxy_user, proxy_pass)
        client
      end
    end 
  end
end