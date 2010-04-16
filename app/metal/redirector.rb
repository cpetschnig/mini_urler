# Allow the metal piece to run in isolation
require File.expand_path('../../../config/environment',  __FILE__) unless defined?(Rails)

class Redirector
  def self.call(env)
    if env["PATH_INFO"] =~ /^\/([0-9a-zA-Z]{4})$/
      url = RedisMod.conn[$1]
      return [301, {"Location" => url}, ['']] if url
    end
    [404, {"Content-Type" => "text/html", "X-Cascade" => "pass"}, ["Not Found"]]
  end
end
