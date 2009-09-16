require 'hpricot'
require 'open-uri'
require 'yaml'

class Crawler
  
  attr :crawl_list, :docs
  
  def initialize( filename = nil )
    load_file filename unless filename.nil?
    @docs = Array.new
  end
  
  # Load yaml list.
  def load_file( filename )
    @crawl_list = YAML.load_file filename
    @crawl_list = @crawl_list[ 'list' ]
  end
  
  # Parse urls from crawl list.
  def parse_urls
    @crawl_list.each do | site |
      doc = open( site ) { | f | Hpricot f }
      @docs << doc
    end    
    @docs
  end
  
end

#c = Crawler.new( 'crawl_list.yml' )