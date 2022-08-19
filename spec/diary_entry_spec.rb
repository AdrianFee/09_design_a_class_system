require "diary_entry"

RSpec.describe DiaryEntries do
    it "returns title" do
        diary_entry = DiaryEntries.new("My new friend", "Rainy Monday and number was 07752377403")
        result = diary_entry.title
        expect(result).to eq "My new friend"
    end

    it "returns entry" do
        diary_entry = DiaryEntries.new("My new friend", "Rainy Monday and number was 07752377403")
        result = diary_entry.entry
        expect(result).to eq "Rainy Monday and number was 07752377403"
    end

    it "returns contact" do
        diary_entry = DiaryEntries.new("My new friend", "Rainy Monday and number 234 was 07752377403")
        result = diary_entry.get_contact
        expect(result).to eq "07752377403"
    end

    it "returns contact" do
        diary_entry = DiaryEntries.new("My new friend", "Rainy Monday and number ")
        result = diary_entry.get_contact
        expect(result).to eq ""
    end

    it "returns the time it takes to read the content" do
    diary_entry = DiaryEntries.new("Rainy Monday", ("Rainy " * 200))
    result = diary_entry.reading_time(100)
    expect(result).to eq 2
    end
end