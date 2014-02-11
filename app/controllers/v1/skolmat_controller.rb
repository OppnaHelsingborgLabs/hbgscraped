# encoding: utf-8
class V1::SkolmatController < V1::BaseController

	def index 
		@source = "http://www.helsingborg.se/Medborgare/Utbildning-och-barnomsorg/Skolmat-lunch-helsingborg/maltidsservice-meny/"        

        # @menues = Rails.cache.read("skolmat:index:menu")
        # if @menues.nil? 
            @menues = Array.new
            doc = Nokogiri::HTML(open(@source)) rescue nil
                    
            items = doc.xpath("//ul[contains(@class, 'tabs-content')]/li")
            items.each do |item|
                week = item.xpath("h2").text.gsub("Matsedel för Måltidsservice vecka ", "")
                next if week.empty?

                week_menu = Array.new
      			days = item.xpath("h3")
      			days.each do |day|
      				date = day.text
      				menu = day.xpath("following-sibling::p[1]").text
      				week_menu.push({"date" => date, 
      					            "menu" => menu})
      			end
      			@menues.push({"number" => week, 
      				          "menues" => week_menu})
            end 
        #     Rails.cache.write("skolmat:index:plans", @menues, expires_in: 12.hours)
        # end
      
        render :index, :content_type => @content_type
	end
end