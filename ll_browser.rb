require 'net/http'

class LinkedList
  LATEST = 56
  CACHE = "linkedlist_issues"

  def self.method_missing(name, *args, &block)    
    LinkedListIssue.new("#{LinkedList::CACHE}/#{name.to_s.gsub(/issue_/, '')}.html")
  end

  def self.respond_to?(method)
    method.to_s.match(/^issue_\d{3}/) || super
  end

  def self.download_and_cache
    Dir.mkdir LinkedList::CACHE unless Dir.exists? LinkedList::CACHE

    if !File.exists? "#{LinkedList::CACHE}/%03d.html" % LinkedList::LATEST
      LinkedList::LATEST.times do |i|
        File.open("#{LinkedList::CACHE}/%03d.html" % (i+1), "w") do |f| 
          puts "downloading issue #{i+1}"
          f.write(Net::HTTP.get 
                  URI("http://www.linkedlistnyc.org/archive/issue_%03d.html" % (i+1)))
        end
      end

      return true
    end
    return false
  end
end

class LinkedListIssue < File
  def initialize *args
    super *args
  end

end

LinkedList.download_and_cache
five = LinkedList.issue_005
puts five.read

