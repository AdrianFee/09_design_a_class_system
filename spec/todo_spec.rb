
require "todo"

RSpec.describe Todo do
    it "adds a new task" do
        todo = Todo.new("Water the fish")
        result = todo.task
        expect(result).to eq "Water the fish"
    end

    it "marks a task as done and returns done? as true" do
        todo = Todo.new("Water the dog")
        todo.mark_done!
        result = todo.done?
        expect(result).to eq true
    end

    it "returns false if tasks is not done" do
        todo = Todo.new("Water the dog")
        result = todo.done?
        expect(result).to eq false
    end

end