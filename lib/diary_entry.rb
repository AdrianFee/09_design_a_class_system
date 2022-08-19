class DiaryEntries
    def initialize(title, entry)
        @title = title
        @entry = entry
    end 

    def title
    @title
    end

    def entry
        @entry
    end

    def get_contact
        entries_string = @entry.split(" ")
        number_string = entries_string.select { |string| string.to_i > 0}
        contact_number = number_string.select { |string| string.length === 11}
        return contact_number.join("")
    end 

    def reading_time(wpm)
        content_w = @entry.split(" ").length
        return (content_w.to_i/ wpm.to_i).ceil
        # returns integer of how many minutes it takes to read the entry based on a wpm value
    end 
end 