# Multi-Class Planned Design Recipe: Keep a diary of entries and tasks.

## 1. Describe the Problem

> As a user
> So that I can record my experiences
> I want to keep a regular diary

> As a user
> So that I can reflect on my experiences
> I want to read my past diary entries

> As a user
> So that I can reflect on my experiences in my busy day
> I want to select diary entries to read based on how much time I have and my reading speed

> As a user
> So that I can keep track of my tasks
> I want to keep a todo list along with my diary

> As a user
> So that I can keep track of my contacts
> I want to see a list of all of the mobile phone numbers in all my diary entries


## 2. Design the Class System

_Consider diagramming out the classes and their relationships. Take care to
focus on the details you see as important, not everything. The diagram below
uses asciiflow.com but you could also use excalidraw.com, draw.io, or miro.com_

```
TodoList
Todo
DiaryEntry
Diary

    diary of entries
    add new entry
    select phone number from entry & add to contacts list
    contacts list
    read past entries
    select diary entries based on time available and reading speed 

    todo list
    add todo task
    mark task as done
    
                            ┌───────────────────────────┐
                            │ Diary                     │
                            │ --------                  │
                            │ all - return all entries  │
         ┌──────────────────┤ select_based_on_title     │
         │                  │ select_based_on_time      │
         │                  │ contacts_list             │
         │                  │ add                       │
         │                  └────────────┬──────────────┘
         │                               │
         │                               │ contains todo
         │                               │ list and entry
         │                               │ list
┌────────▼──────────┐       ┌────────────▼──────────────┐
│ TodoList          │       │ DiaryEntries              │
│ ---------         │       │ -------------             │
│ add               │       │                           │
│ incomplete        │       │ get_contact               │
│ complete          │       └───────────────────────────┘
│                   │
└───────┬───────────┘
        │contains a
        │list of
        │todos
┌───────▼───────┐
│ Todo          │
│ ---------     │
│ task          │
│ mark_done!    │
│ done?         │
└───────────────┘


```

_Also design the interface of each class in more detail._

```ruby
class Todo
        def initialize(task)
        end 
        
        def task # return the task
        end 

        def mark_done! # marks the task as complete
        end 

        def done? # returns true if task is complete, false if task incomplete
        end
end 

class TodoList 
        def initialize # opens a array
        end 

        def add # add is an instance of todo
        end 

        def all_tasks # returns all tasks
        end 

        def incomplete  # returns list of incomplete tasks
        end 

        def complete # returns a list of completed tasks
        end 
end 

class DiaryEntries
        def initialize(title, entry) # title and entry are strings
        end 

        def title
        
        end

        def entry
        
        end

        def get_contact # return phone number from the entry
        end 

        def reading_time(wpm) # returns integer of how many minutes it takes to read the entry based on a wpm value
        end 
end 

class Diary
        def initialize # opens empty arrays for entries and contacts
        end

        def add_entry(entry) # entry is an instance of DiaryEntries
        end 

        def all # returns all entries in the diary
        end 

        def my_todo_lists # return a list of todo lists
        end 

        def contacts_list # returns a list of contact numbers
        end 

        def select_based_on_title(keyword) # returns entries with a given title/keyword
        end 

        def select_based_on_time(wpm, mins) # returns most suitable entry for reading time available
        end 

        def add_todo_list(todo_list) # todo is an instance of TodoList
        end 

end 

```

## 3. Create Examples as Integration Tests

_Create examples of the classes being used together in different situations and
combinations that reflect the ways in which the system will be used._

```ruby
# EXAMPLE

todo = Todo.new("this is my task")
todo_list = TodoList.new
todo_list.add(todo)
result = todo_list.all_tasks
expect(result).to eq [todo]

todo = Todo.new("this is my task")
todo_2 = Todo.new("this is my new task")
todo_list = TodoList.new
todo.mark_done!
todo_list.add(todo)
todo_list.add(todo_2)
result = todo_list.complete
expect(result).to eq [todo]

todo = Todo.new("this is my task")
todo_2 = Todo.new("this is my new task")
todo_list = TodoList.new
todo.mark_done!
todo_list.add(todo)
todo_list.add(todo_2)
result = todo_list.incomplete
expect(result).to eq [todo_2]

diary_entry = DiaryEntries.new("Rainy Monday", ("Rainy " * 200))
diary_entry_2 = DiaryEntries.new("Sunny Saturday", ("Sunny " * 200))
diary = Diary.new
diary.add_entry(diary_entry)
diary.add_entry(diary_entry_2)
result = diary.all
expect(result).to eq [diary_entry, diary_entry_2]

diary = Diary.new
todo_list = TodoList.new 
todo = Todo.new("this is my task")
todo_2 = Todo.new("sweep the rain")
todo_list.add(todo)
todo_list.add(todo_2)
diary.add_todo_list(todo_list)
result = diary.my_todo_lists
expect(result).to eq [todo_list]

diary_entry = DiaryEntries.new("My new friend", "Rainy Monday and number was 07752377403")
diary_entry_2 = DiaryEntries.new("My old friend", "Sunny Monday and number was 07752399903")
diary = Diary.new
diary.add_entry(diary_entry)
diary.add_entry(diary_entry_2)
result = diary.contacts_list
expect(result).to eq ["07752377403", "07752399903"]

diary_entry = DiaryEntries.new("My new friend", "Rainy Monday and number was 07752377403")
diary_entry_2 = DiaryEntries.new("My old friend", "Sunny Monday and number was 07752399903")
diary = Diary.new
diary.add_entry(diary_entry)
diary.add_entry(diary_entry_2)
result = diary.select_based_on_title("Rainy")
expect(result).to eq diary_entry

diary_entry = DiaryEntries.new("My new friend", "Rainy Monday and number was 07752377403")
diary_entry_2 = DiaryEntries.new("My old friend", "Sunny Monday and number was 07752399903")
diary = Diary.new
diary.add_entry(diary_entry)
diary.add_entry(diary_entry_2)
result = diary.select_based_on_title("number")
expect(result).to eq [diary_entry, diary_entry_2]

diary_entry = DiaryEntries.new("Rainy Monday", ("Rainy " * 205))
diary_entry_2 = DiaryEntries.new("Sunny Saturday", ("Sunny " * 198))
diary = Diary.new
diary.add_entry(diary_entry)
diary.add_entry(diary_entry_2)
result = diary.select_based_on_time(200, 1)
expect(result).to eq diary_entry_2

```

## 4. Create Examples as Unit Tests

_Create examples, where appropriate, of the behaviour of each relevant class at
a more granular level of detail._

```ruby
# EXAMPLE

#  Todo

todo = Todo.new("Water the fish")
result = todo.task
expect(result).to eq "Water the fish"

todo = Todo.new("Water the dog")
todo.mark_done!
result = todo.done?
expect(result).to eq true

todo = Todo.new("Water the dog")
result = todo.done?
expect(result).to eq false


#    DiaryEntries

diary_entry = DiaryEntries.new("My new friend", "Rainy Monday and number was 234 07752377403")
result = diary_entry.get_contact
expect(result).to eq "07752377403"

diary_entry = DiaryEntries.new("Rainy Monday", ("Rainy " * 200))
result = diary_entry.reading_time(100)
expect(result).to eq 2

```

_Encode each example as a test. You can add to the above list as you go._

## 5. Implement the Behaviour

_After each test you write, follow the test-driving process of red, green,
refactor to implement the behaviour._


<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---

**How was this resource?**  
[😫](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/golden-square&prefill_File=resources/multi_class_recipe_template.md&prefill_Sentiment=😫) [😕](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/golden-square&prefill_File=resources/multi_class_recipe_template.md&prefill_Sentiment=😕) [😐](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/golden-square&prefill_File=resources/multi_class_recipe_template.md&prefill_Sentiment=😐) [🙂](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/golden-square&prefill_File=resources/multi_class_recipe_template.md&prefill_Sentiment=🙂) [😀](https://airtable.com/shrUJ3t7KLMqVRFKR?prefill_Repository=makersacademy/golden-square&prefill_File=resources/multi_class_recipe_template.md&prefill_Sentiment=😀)  
Click an emoji to tell us.

<!-- END GENERATED SECTION DO NOT EDIT -->