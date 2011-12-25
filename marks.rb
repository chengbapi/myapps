
#自己写一个简单网络爬虫，准备把xmarks下面都爬出来。

require 'open-uri'
require 'thread'


$regexp_words =   /<a class\=\"topic-instance\" href\=\"([\s|\S]*?)\">/;
$regexp_numbers =   /:: Page 1 of (.*) ::/;
$regexp_pages = /<b>Page 1<\/b>/
$links = []
$regexp_websites = /<span class\=\"title\">([\s|\S]*?)<\/span>/
$regexp_web = /<a href\=\"([\s|\S]*?)" rel=\"nofollow\">/
$counter = 0

class Crawl
	def initialize uri 
		@url = uri
    @words = []


  end
  def get_links char
    number = 0
    herf = @url + "/topics/" + char + "/1"    #先打开网站
    begin
      open(herf) do |f|     #读入字母种子页面并获取页码数
        number = f.read.scan($regexp_numbers).to_s.to_i
        p number
      end
   
    
      1.upto(number) { |i|
        herf = @url + "/topics/" + char + "/" + i.to_s
        @html = open(herf) do |f|             #每页读过去获取所有存在的单词
          f.read.scan($regexp_words).join("/").scan(/\/topic\/([\s|\S]*?)\//) { |unusedlocal|  @words.push(unusedlocal.to_s)}
         
        end
         p @words
      }
    rescue
         @html = nil
         p "error!   #{$!}"
    end
   end
   def crawl
       begin
         @words.each do |item|
           $counter += 1
          File.open("websites.txt", "a") { |file|  file.puts $counter.to_s + "." + item }
           Crawl.get_websites(1,item)

         end
        rescue
          p "error!   #{$!}"
        end
   end
   def self.get_websites pager,item

     herf = "http://www.xmarks.com" + "/topic/sites/"  + pager.to_s + "/" + item +  "?created=all"
     p herf
     begin
      open(herf) do |f|
         html = f.read
         File.open("websites.txt", "a") do |file|
           file.puts html.scan($regexp_websites).flatten.join(" ").scan($regexp_web).flatten.join("\n")
           end
         if html.slice(/\">Next/) #如果还有下一页
           self.get_websites((pager+1),item)

         end
       end
        rescue $!
        p "error!   #{$!}"

     end
   end 
end

c = Crawl.new("http://www.xmarks.com")
 
'a'.upto('z') do |i|
  c.get_links(i)
  c.crawl
  

 end


