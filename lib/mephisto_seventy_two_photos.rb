require 'rss/2.0'
require 'open-uri'

module SeventyTwoPhotos

  def get_photos(feed, thumb_size='s', use_styles='true', border='#CCCCCC', hover='#CCCCCC')
    if thumb_size == "s"
      size = 60
    elsif thumb_size == "m"
      size = 90
    elsif thumb_size == "l"
      size = 120
    end
    feed_url = feed
    output = "" 
    unless use_styles == "false"
      output += "<style type=text/css>div.seventy_two_photos a img{float:left;width: #{size}px;height: #{size}px;margin-right: 10px; margin-top: 10px; border: 1px solid #{border};padding: 3px;} div.seventy_two_photos a:hover img{background: #{hover};}</style>"    
    end
    open(feed_url) do |http|
      response = http.read
      result = RSS::Parser.parse(response, false)
      result.items.each_with_index do |item, i|
        output += "<div class=seventy_two_photos>#{item.description}</div>" if i < 50  
      end  
    end
    output += '<div style="clear:both;"></div>'
    return output
  end

end