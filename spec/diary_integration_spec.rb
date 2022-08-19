require "diary"
require "diary_entry"

RSpec.describe "Diary Integration" do
    it "returns all diary entries" do
        diary_entry = DiaryEntries.new("Rainy Monday", ("Rainy " * 200))
        diary_entry_2 = DiaryEntries.new("Sunny Saturday", ("Sunny " * 200))
        diary = Diary.new
        diary.add_entry(diary_entry)
        diary.add_entry(diary_entry_2)
        result = diary.all
        expect(result).to eq [diary_entry, diary_entry_2]
    end

    it "returns empty array when there are no diary entries" do
        diary = Diary.new
        result = diary.all
        expect(result).to eq []
    end

    it "returns all of our todo list" do
        diary = Diary.new
        todo_list = TodoList.new 
        todo = Todo.new("this is my task")
        todo_2 = Todo.new("sweep the rain")
        todo_list.add(todo)
        todo_list.add(todo_2)
        diary.add_todo_list(todo_list)
        result = diary.my_todo_lists
        expect(result).to eq [todo_list]
    end

    it "returns empty array when there are no todo lists" do
        diary = Diary.new
        result = diary.my_todo_lists
        expect(result).to eq []
    end

    it "returns a list of contact numbers from the entries" do
        diary_entry = DiaryEntries.new("My new friend", "Rainy Monday and number was 07752377403")
        diary_entry_2 = DiaryEntries.new("My old friend", "Sunny Monday and number was 07752399903")
        diary_entry_3 = DiaryEntries.new("My really new friend", "Pink Wednesday and number was 09903")
        diary = Diary.new
        diary.add_entry(diary_entry)
        diary.add_entry(diary_entry_2)
        diary.add_entry(diary_entry_3)
        result = diary.contacts_list
        expect(result).to eq ["07752377403", "07752399903"]
    end

    it "returns a list of entries that include the keyword" do
        diary_entry = DiaryEntries.new("My new friend", "Rainy Monday and number was 07752377403")
        diary_entry_2 = DiaryEntries.new("My old friend", "Sunny Monday and number was 07752399903")
        diary = Diary.new
        diary.add_entry(diary_entry)
        diary.add_entry(diary_entry_2)
        result = diary.select_based_on_title("Rainy")
        expect(result).to eq [diary_entry]
    end
end