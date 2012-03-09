require "net/http"
require "nokogiri"

class LinkedListNYC
  # gets latest from the link on the linkedlist home page
  Latest = Net::HTTP.get(URI("http://www.linkedlistnyc.org/")).
    to_s.match(/archive\/issue_([\d]{3}).html/).to_s.match(/[\d]{3}/)[0].to_i
  Cache = "linkedlist_issues"

  def self.method_missing(name, *args, &block)    
    if name.match(/issue_[\d]{3}/)
      issue = name.to_s.gsub(/issue_/, '')
      if File.exists? "#{LinkedListNYC::Cache}/#{issue}.html"
        Nokogiri::HTML(File.new("#{LinkedListNYC::Cache}/#{issue}.html"))
      else
        Nokogiri::HTML(Net::HTTP.get(URI(
          "http://www.linkedlistnyc.org/archive/issue_#{issue}.html")))
      end
    else
      super
    end
  end

  def self.respond_to?(method)
    method.to_s.match(/^issue_[\d]{3}/) || super
  end

  def self.latest
    self.send("issue_%03d" % LinkedListNYC::Latest)
  end

  def self.download_and_cache
    Dir.mkdir LinkedListNYC::Cache unless Dir.exists? LinkedListNYC::Cache

    LinkedListNYC::Latest.times do |i|
      if !File.exists? "#{LinkedListNYC::Cache}/%03d.html" % (i+1)
        File.open("#{LinkedListNYC::Cache}/%03d.html" % (i+1), "w") do |f| 
          puts "downloading issue #{i+1}"
          f.write(Net::HTTP.get(
            URI("http://www.linkedlistnyc.org/archive/issue_%03d.html" % (i+1))))
        end
      end
    end
    return true
  end
end

#LinkedListNYC.download_and_cache

#issue = LinkedListNYC.issue_005
