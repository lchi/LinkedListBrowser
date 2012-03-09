require "net/http"
require "nokogiri"

class LinkedListNYC
  LATEST = 56
  CACHE = "linkedlist_issues"

  def self.method_missing(name, *args, &block)    
    html = Nokogiri::HTML(File.new(
      "#{LinkedListNYC::CACHE}/#{name.to_s.gsub(/issue_/, '')}.html"))
  end

  def self.respond_to?(method)
    method.to_s.match(/^issue_\d{3}/) || super
  end

  def self.download_and_cache
    Dir.mkdir LinkedListNYC::CACHE unless Dir.exists? LinkedListNYC::CACHE

    if !File.exists? "#{LinkedListNYC::CACHE}/%03d.html" % LinkedListNYC::LATEST
      LinkedListNYC::LATEST.times do |i|
        File.open("#{LinkedListNYC::CACHE}/%03d.html" % (i+1), "w") do |f| 
          puts "downloading issue #{i+1}"
          f.write(Net::HTTP.get(
            URI("http://www.linkedlistnyc.org/archive/issue_%03d.html" % (i+1))))
        end
      end

      return true
    end
    return false
  end
end

#LinkedListNYC.download_and_cache

#issue = LinkedListNYC.issue_005
