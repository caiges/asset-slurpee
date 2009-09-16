require 'crawler'

describe Crawler do

  before( :each ) do
    @crawler = Crawler.new( 'crawl_list.yml' )
  end
  
  it "should return an array when parse_urls is called." do
    @crawler.parse_urls().instance_of?( Array ).should == true
  end
  
  it "should parse the correct number of targets." do
    @crawler.parse_urls().length.should == @crawler.crawl_list.length
  end
  
  it "should parse and return the correct number of Hpricot docs." do
    @crawler.parse_urls().each do | doc |
      doc.instance_of?( Hpricot::Doc ).should == true
    end
  end
  
end