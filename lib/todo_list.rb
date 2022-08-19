class TodoList
    def initialize # opens a array
        @todo_list = []
    end 

    def add(todo)
        @todo_list << todo
    end 

    def all_tasks # returns all tasks
        return @todo_list
    end 

    def complete
        @todo_list.select {|todo| todo.done?}
      end

      def incomplete
        @todo_list.select {|todo| !todo.done?}
      end
end