require 'rails_helper'

describe Video do
  it { should belong_to(:category) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:description) }
  it { should have_many(:reviews).order(created_at: :desc) }
  
  describe "search_by_title" do
    it "returns an empty array if no video matched" do
      alien = Video.create(title: "Alien", description: "Classic sci-fi")
      lala_land = Video.create(title: "La La Land", description: "Great music!")
      expect(Video.search_by_title("hello")).to eq([])
    end
    
    it "returns an array of one video for an exact match" do
      alien = Video.create(title: "Alien", description: "Classic sci-fi")
      lala_land = Video.create(title: "La La Land", description: "Great music!")
      expect(Video.search_by_title("Alien")).to eq([alien])
    end
    
    it "returns an array of one video for a partial match" do 
      alien = Video.create(title: "Alien", description: "Classic sci-fi")
      lala_land = Video.create(title: "La La Land", description: "Great music!")
      expect(Video.search_by_title("lie")).to eq([alien])
    end
    
    it "returns an array of one video for case sensitive partial match" do 
      alien = Video.create(title: "Alien", description: "Classic sci-fi")
      lala_land = Video.create(title: "La La Land", description: "Great music!")
      expect(Video.search_by_title("ali")).to eq([alien])
    end
    
    it "returns an array of all matches ordered by created_at" do
      alien = Video.create(title: "Alien", description: "Classic sci-fi", created_at: 1.day.ago)
      lala_land = Video.create(title: "La La Land", description: "Great music!")
      expect(Video.search_by_title("a")).to eq([lala_land, alien])
    end
    
    it "returns an empty array if the search term is empty or whitespace" do
      alien = Video.create(title: "Alien", description: "Classic sci-fi")
      lala_land = Video.create(title: "La La Land", description: "Great music!")
      expect(Video.search_by_title(" ")).to eq([])
      expect(Video.search_by_title("")).to eq([])
    end
  end
  
  describe ".search", :elasticsearch do
    
    let(:refresh_index) do
      Video.import
      Video.__elasticsearch__.refresh_index!
    end

    context "with title" do
      it "returns no results when there's no match" do
        Fabricate(:video, title: "Futurama")
        refresh_index
  
        expect(Video.search("whatever").records.to_a).to eq []
      end
  
      it "returns an empty array when there's no search term" do
        futurama = Fabricate(:video)
        south_park = Fabricate(:video)
        refresh_index
  
        expect(Video.search("").records.to_a).to eq []
      end
  
      it "returns an array of 1 video for title case insensitve match" do
        futurama = Fabricate(:video, title: "Futurama")
        south_park = Fabricate(:video, title: "South Park")
        refresh_index
  
        expect(Video.search("futurama").records.to_a).to eq [futurama]
      end
  
      it "returns an array of many videos for title match" do
        star_trek = Fabricate(:video, title: "Star Trek")
        star_wars = Fabricate(:video, title: "Star Wars")
        refresh_index
  
        expect(Video.search("star").records.to_a).to match_array [star_trek, star_wars]
      end
    end
  end
end
