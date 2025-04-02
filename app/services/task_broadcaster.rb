class TaskBroadcaster
  
  def self.broadcast_task(task, action: :create)
    puts "Broadcasting article #{action}: #{task.title}"

    case action
    when :create
      Turbo::StreamsChannel.broadcast_append_to(
        "task_list",
        target: "task-list",
        partial: "tasks/task",
        locals: { task: task }
      )
    when :update
      Turbo::StreamsChannel.broadcast_replace_to(
        "task_list",
        target: dom_id(article, "id"),
        partial: "tasks/task",
        locals: { article: article }
      )
    end
  end

end