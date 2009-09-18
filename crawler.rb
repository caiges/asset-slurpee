require 'hpricot'
require 'open-uri'
require 'yaml'

class Crawler
  
  attr :crawl_list, :docs, :targets
  
  def initialize( filename = nil, pattern = nil )
    @docs = Array.new
    @targets = Array.new
    load_file filename unless filename.nil?
    parse_urls
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
  
  def slurp_news21
    
    @docs.each do | doc |
      school = Hash.new
      school[ 'title' ] = doc.search( "//div[@id='topic_detail']/h1").inner_html
      school[ 'stories' ] = Array.new
      story = Hash.new
      links = doc.search( "//div[@id='topic_detail']/ul/li/span/a[@href]" )
      links.each do | link |
        story[ 'title' ] = link.inner_html
        story[ 'title' ].gsub! ' ', '_'
        story[ 'title' ].gsub! ':', '_'
        story[ 'url' ] = link.get_attribute( 'href' )
        school[ 'stories' ] << story
        p story[ 'title' ]
        p story[ 'url' ]
      end
      #p school
      @targets << school
    end
    
  end
  
end

c = Crawler.new( 'crawl_list.yml' )
c.slurp_news21