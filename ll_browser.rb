require 'net/http'

class LinkedList
  def method_missing(name, *args)    
    response = Net::HTTP.get URI("http://www.linkedlistnyc.org/archive/#{name}.html")
  end
  
end

linkedList = LinkedList.new
puts linkedList.issue_005
