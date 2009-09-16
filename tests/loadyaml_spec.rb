require 'crawler'

describe Crawler do
  
  before( :each ) do
    @crawler = Crawler.new( 'crawl_list.yml' )
  end
  
  it "yaml list should load properly." do
    lambda{ @crawler.load_file( 'crawl_list.yml' ) }.should_not raise_error
  end
  
  it "yaml list shouldn't load properly." do
    crawler = Crawler.new
    lambda{ crawler.load_file( 'not_there_foo.yml' ) }.should raise_error
  end
  
  it "length should be 8." do
    @crawler.crawl_list.length.should == 8
  end

end