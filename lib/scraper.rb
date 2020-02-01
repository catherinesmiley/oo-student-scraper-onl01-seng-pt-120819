require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    students = []
    html = open(index_url)
    index = Nokogiri::HTML(html)
    
    index.css("div.student-card").each do |student|
      student_details = {}
      student_details[:name] = student.css("h4.student-name").text
      student_details[:location] = student.css("p.student-location").text
      # url = student.css("a").attribute("href").value
      # student_details[:profile_url] = index_url.chomp("student-scraper-test-page/index.html") + url   
      student_details[:profile_url] = student.css("a").attribute("href").value
      students << student_details 
    end 
    students 
    
    # student: index.css("div.student-card")
    # name: index.css("h4.student-name").text
    # location: index.css("p.student-location").text
    # profile_url: index.css("a").attribute("href").value 
    
  end

  def self.scrape_profile_page(profile_url)
    student_profile = {}
    html = open(profile_url)
    index = Nokogiri::HTML(html)
    index.css("div.social-icon-container").each do |social_media|
      binding.pry 
      student_profile[:twitter] = social_media.css("a").attribute("href").value 
      student_profile[:linkedin] = social_media.css("a").attribute("href").value 
    end 
  end

end

