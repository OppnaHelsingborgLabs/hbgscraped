# encoding: utf-8
class V1::DetaljplanerController < V1::BaseController

    def test
        render :test , :content_type => @content_type
    end

    def index       
        @source = "http://www.helsingborg.se/Medborgare/Trafik-och-stadsplanering/Oversiktsplan-och-detaljplaner/Detaljplanering/detaljplaner-under-arbete/"        

        @plans = Rails.cache.read("detaljplaner:index:plans")
        if @plans.nil? 
            @plans = Array.new
            doc = Nokogiri::HTML(open(@source)) rescue nil
                    
            items = doc.xpath("//tr[contains(@class, 'item-first-row')]")
            items.each do |item|
                name = item.xpath("td[1]").text
                area = item.xpath("td[2]").text
                stage = item.xpath("td[3]").text
                consultation = item.xpath("td[4]").text
                review = item.xpath("td[5]").text

                details = item.next_element.xpath("td[1]/div") 
                image = details.xpath("img/@src").text
                image = "http://helsingborg.se" + image unless image.empty?
                intro = details.xpath("p[1]").text
                description = details.xpath("p[2]").text   

                # Not perfect, due to inconsistent HTML most but not all administrators are extracted         
                administrator = details.xpath("p[contains(text(), 'Handläggare')]").text.sub("Handläggare: ", "")

                # Extracting documents in two different ways due to inconsistent HTML
                documents = Array.new
                details.xpath("h2[contains(text(), 'Dokument')]/following-sibling::ul/li/a").each do |document|
                    href = "http://helsingborg.se" + document['href'] unless document['href'].empty?
                    documents.push({"title" => document.text, "href" => href})
                end
                details.xpath("h2[contains(text(), 'Dokument')]/following-sibling::p/a").each do |document|
                    href = "http://helsingborg.se" + document['href'] unless document['href'].empty?
                    documents.push({"title" => document.text, "href" => href})
                end

                @plans.push({"name" => name,
                             "area" => area,
                             "stage" => stage,
                             "consultation" => consultation,
                             "review" => review,
                             "image" => image,
                             "intro" => intro,
                             "description" => description,
                             "administrator" => administrator,
                             "documents" => documents})
            end 
            Rails.cache.write("detaljplaner:index:plans", @plans, expires_in: 12.hours)
        end

        render :index, :content_type => @content_type
    end
end
