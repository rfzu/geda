class CianParser

  def self.parse 
    puts 'start!'
    url = 'http://www.cian.ru/cat.php'
    params = {
      'foot_min'         => 15,  
      'sost_type'        => 1, 
      'metro'            => 154,  
      'only_foot'        => 2, 
      'engine_version'   => 2,  
      'p'                => 1, 
      'room2'            => 1, 
      'minfloor'         => 2,  
      'room1'            => 1, 
      'deal_type'        => 'sale',  
      'offer_type'       => 'flat', 
      'room9'            => 1,
    }

    request = Typhoeus::Request.new(url, params: params)
    resp = request.run

    n = Nokogiri resp.body
    flats = n.css('div.serp-list')[0].css('div.serp-item')
    page_count = n.css('div.pager_pages').css('a').count
    puts "page_count: #{page_count}"

    (2..page_count+1).each do |page_num|
      params_page = params
      params_page['p'] = page_num
      request = Typhoeus::Request.new(url, params: params)
      resp = request.run
      n = Nokogiri resp.body
      flats += n.css('div.serp-list')[0].css('div.serp-item')
    end

    puts "got #{flats.count} flats"

    data = []
    (1..159).each |metro|
      flats.each do |flat|
        price   = flat.css('div.serp-item__price-col/div.serp-item__solid').to_s.gsub(',','.').match(/\d+\.\d+/).try(:[], 0)
        price ||= flat.css('div.serp-item__price-col/div.serp-item__solid').to_s.gsub(',','.').match(/\d+/).try(:[], 0)
        price = price.to_f
        result = {
          :metro         => flat.css('div.serp-item__solid/a').children.to_s,
          :flat_url      => flat.attributes['href'].value,
          :address       => flat.css('div.serp-item__address-precise').text.gsub("\n",'').gsub("\t",''),
          :minutes       => flat.css('div.serp-item__distance').children.to_s.match(/\d+/)[0].to_i,
          :price         => price
        }

        data << result
        puts result
      end
    end
    # data = data.sort_by {|q| q[:price]}
    data
  end
end