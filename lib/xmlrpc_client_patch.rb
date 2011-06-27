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
    
    def do_rpc(request, async=false)
      header = {  
       "User-Agent"     =>  USER_AGENT,
       "Content-Type"   => "text/xml; charset=utf-8",
       "Content-Length" => request.size.to_s, 
       "Connection"     => (async ? "close" : "keep-alive")
      }

      header["Cookie"] = @cookie        if @cookie
      header.update(@http_header_extra) if @http_header_extra

      if @auth != nil
        # add authorization header
        header["Authorization"] = @auth
      end
 
      resp = nil
      @http_last_response = nil

      if async
        # use a new HTTP object for each call 
        Net::HTTP.version_1_2
        http = Net::HTTP.new(@host, @port, @proxy_host, @proxy_port) 
        http.use_ssl = @use_ssl if @use_ssl
        http.read_timeout = @timeout
        http.open_timeout = @timeout
        
        # post request
        http.start {
          resp = http.post2(@path, request, header) 
        }
      else
        # reuse the HTTP object for each call => connection alive is possible
        # we must start connection explicitely first time so that http.request
        # does not assume that we don't want keepalive
        @http.start if not @http.started?
        puts request
        # post request
        resp = @http.post2(@path, request, header) 
      end
  
      @http_last_response = resp

      data = resp.body
      puts data
      if resp.code == "401"
        # Authorization Required
        raise "Authorization failed.\nHTTP-Error: #{resp.code} #{resp.message}" 
      elsif resp.code[0,1] != "2"
        raise "HTTP-Error: #{resp.code} #{resp.message}" 
      end

      ct = parse_content_type(resp["Content-Type"]).first
      if ct != "text/xml"
        if ct == "text/html"
          raise "Wrong content-type (received '#{ct}' but expected 'text/xml'): \n#{data}"
        else
          raise "Wrong content-type (received '#{ct}' but expected 'text/xml')"
        end
      end

      expected = resp["Content-Length"] || "<unknown>"
      if data.nil? or data.size == 0 
        raise "Wrong size. Was #{data.size}, should be #{expected}" 
      elsif expected != "<unknown>" and expected.to_i != data.size and resp["Transfer-Encoding"].nil?
        raise "Wrong size. Was #{data.size}, should be #{expected}"
      end

      set_cookies = resp.get_fields("Set-Cookie")
      if set_cookies and !set_cookies.empty?
        require 'webrick/cookie'
        @cookie = set_cookies.collect do |set_cookie|
          cookie = WEBrick::Cookie.parse_set_cookie(set_cookie)
          WEBrick::Cookie.new(cookie.name, cookie.value).to_s
        end.join("; ")
      end

      return data
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