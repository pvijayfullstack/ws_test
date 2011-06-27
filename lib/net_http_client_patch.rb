require 'net/http'
require 'soap/netHttpClient'

module SOAP
  class NetHttpClient 
    def post(url, req_body, header = {})
      unless url.is_a?(URI)
        url = URI.parse(url)
      end
      extra = header.dup
      extra['User-Agent'] = @agent if @agent
      res = start(url) { |http|
        http.post(url.request_uri, req_body, extra)
      }
      puts req_body
      puts res
      Response.new(res)
    end
    
    private
  
    def start(url)
      http = create_connection(url)
      response = nil
      http.start { |worker|
        response = yield(worker)
        worker.finish
      }
      @debug_dev << response.body if @debug_dev
      response
    end
  
    
    def create_connection(url)
      proxy_host = proxy_port = nil
      proxy_user = proxy_pass = nil
      proxy_auth = false
      unless no_proxy?(url)
        proxy_host = @proxy.host
        proxy_port = @proxy.port
        unless @proxy.userinfo.nil? or @proxy.userinfo == ""
          proxy_auth = true
          proxy_user = @proxy.userinfo.split(":")[0]
          proxy_pass = @proxy.userinfo.split(":")[1] 
        end
      end
      puts proxy_user
      if proxy_auth
        http = Net::HTTP::Proxy(proxy_host, proxy_port, proxy_user, proxy_pass).new(url.host, url.port)
      else
        http = Net::HTTP::Proxy(proxy_host, proxy_port).new(url.host, url.port)
      end
      
      if http.respond_to?(:set_debug_output)
        http.set_debug_output(@debug_dev)
      end
      http.open_timeout = @connect_timeout if @connect_timeout
      http.read_timeout = @receive_timeout if @receive_timeout
      case url
      when URI::HTTPS
        if SSLEnabled
          http.use_ssl = true
        else
          raise RuntimeError.new("Cannot connect to #{url} (OpenSSL is not installed.)")
        end
      when URI::HTTP
        # OK
      else
        raise RuntimeError.new("Cannot connect to #{url} (Not HTTP.)")
      end
      http
    end  
  end
end
