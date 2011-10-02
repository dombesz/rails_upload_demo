module Thin
  class Server
    def self.progress
      @@progress||={}
    end  
  end
  
end