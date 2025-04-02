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
      Turbo::StreamsChannel.broadcast_replace_to(
        "task_list",
        target: "task_count",
        html: Task.count.to_s
      )
      Turbo::StreamsChannel.broadcast_replace_to(
        "task_list",
        target: "completed_task_count",
        html: Task.where(status: "Completed").count.to_s
      )
    when :update
      Turbo::StreamsChannel.broadcast_replace_to(
        "task_list",
        target: dom_id(task),
        partial: "tasks/task",
        locals: { task: task }
      )
      Turbo::StreamsChannel.broadcast_replace_to(
        "task_list",
        target: "completed_task_count",
        html: Task.where(status: "Completed").count.to_s
      )
    when :destroy
      Turbo::StreamsChannel.broadcast_remove_to(
        "task_list",
        target: dom_id(task)
      )
      Turbo::StreamsChannel.broadcast_replace_to(
        "task_list",
        target: "completed_task_count",
        html: Task.where(status: "Completed").count.to_s
      )
      Turbo::StreamsChannel.broadcast_replace_to(
        "task_list",
        target: "task_count",
        html: Task.count.to_s
      )
    end
  end


  def self.dom_id(record, prefix = nil)
    ActionView::RecordIdentifier.dom_id(record, prefix)
  end
end