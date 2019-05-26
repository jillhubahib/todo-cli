todo = Todo::Manager.new

case ARGV[0]
when "list","ls"
  Todo::Manager.new(:filter => ARGV[1]).list
when "add","a"
  puts "Added: #{todo.add(ARGV[1..-1].join(" "))}"
when "clear"
  puts todo.clear! && "All todos cleared!"
  todo.list
when "delete", "del", "d"
  puts "Deleted: #{todo.delete(ARGV[1])}"
when "done"
  puts "Done: #{todo.done(ARGV[1])}"
else
  puts "\nUsage: todo [options] COMMAND\n\n"
  puts "Commands:"
  puts "  add TODO        Adds a todo"
  puts "  delete NUM      Removes a todo"
  puts "  done NUM        Completes a todo"
  puts "  clear           Removes all todo"
  puts "  list [FILTER]   Lists all active todos"
end