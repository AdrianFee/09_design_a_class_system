class Diary

    def initialize
         @entries_list = []
         @todo_planner = []
    end

    def add_entry(entry)
        @entries_list << entry
    end 

    def all
        @entries_list
    end 

    def add_todo_list(todo_list)
        @todo_planner << todo_list
    end 

    def my_todo_lists
        @todo_planner
    end 

    def contacts_list
       contact_number_with_blanks = @entries_list.map { |entries| entries.get_contact}
       all_contact_numbers = contact_number_with_blanks.filter { |entry| entry != ""}
       return all_contact_numbers
    end 

    def select_based_on_title(keyword)
        @entries_list.select do |en|
            en.entry.include?(keyword)
        end 
    end 

end