require 'rails_helper'

describe Video do
  it "saves itself" do
    video = Video.new(title: "monk", description: "a great video!")
    video.save
    expect(Video.first).to eq(video)
  end
  
  it "belongs to category" do
    comedies = Category.create(name: "comedies")
    south_park = Video.create(title: "South Park", description: "Funny video", category: comedies)
    expect(south_park.category).to eq(comedies)
  end
  
  it "needs to have a title" do
    video = Video.create(description: "good video!")
    expect(Video.count).to eq(0)
  end
  
  it "needs to have a description" do
    video = Video.create(title: "good video!")
    expect(Video.count).to eq(0)
  end
end