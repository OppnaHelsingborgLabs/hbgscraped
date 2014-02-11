# encoding: utf-8
class V1::EvenemangController < ApplicationController
	
    def index      
    	# Adding the most basic toDate and fromDate parameters, use format YYYY-MM-DD
    	params.has_key?(:to) ? to = params['to'] : to = ''
    	params.has_key?(:from) ? from = params['from'] : from = ''

        @source = "http://www.helsingborg.se/Besokare/gora/listar-interna-evenemang/?TypeOfEvent=&Place=&FromDate="+from+"&ToDate="+to+"&AllEvents=SelectedUnits"

        @events = Rails.cache.read("v1:evenemang:index:events:"+to+":"+from)
        if @events.nil? 
	        doc = Nokogiri::HTML(open(@source)) rescue nil
	        @events = Array.new        

	        items = doc.xpath("//div[@id='Event-List']/ul/li")
	        items.each do |item|
	       		title = item.xpath("div[1]/a/@title").text
	       		href = item.xpath("div[1]/a/@href").text   		
	       		href = "http://helsingborg.se" + href unless href.empty?
	       		image = item.xpath("div[1]/a/img/@src").text
	       		image = "http://helsingborg.se" + image unless (image.empty? || image.include?('http://images.citybreak.com') || image.include?('http://mittkulturkort.se'))
	       		date = item.xpath("div[2]/dl/dd").text
	       		teaser = item.xpath("p[@class='Teaser']").text.gsub('"', '')

	            @events.push({"title" => title,
                           	  "href" => href,
                           	  "date" => date,
                           	  "teaser" => teaser,
                           	  "image" => image})
	        end 
	        Rails.cache.write("v1:evenemang:index:events:"+to+":"+from, @events, expires_in: 12.hours)
	    end

        render :index, :content_type => @content_type
    end
end