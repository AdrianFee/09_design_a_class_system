require "todo"
require "todo_list"

RSpec.describe "Todo List Integration" do
    it "Adds an instance of todo and returns it in all_tasks" do
        todo = Todo.new("this is my task")
        todo_list = TodoList.new
        todo_list.add(todo)
        result = todo_list.all_tasks
        expect(result).to eq [todo]
    end

    it "returns only complete tasks" do
        todo = Todo.new("this is my task")
        todo_2 = Todo.new("this is my new task")
        todo_list = TodoList.new
        todo.mark_done!
        todo_list.add(todo)
        todo_list.add(todo_2)
        result = todo_list.complete
        expect(result).to eq [todo]
    end

    it "returns only incomplete tasks" do
        todo = Todo.new("this is my task")
        todo_2 = Todo.new("this is my new task")
        todo_list = TodoList.new
        todo.mark_done!
        todo_list.add(todo)
        todo_list.add(todo_2)
        result = todo_list.incomplete
        expect(result).to eq [todo_2]
    end
end