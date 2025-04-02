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
      Turbo::StreamsChannel.broadcast_replace_to(
        "task_list",
        target: "status_bar",
        partial: "tasks/progress_bar",
        locals: { completed_width_percent: completed_width_percent, remaining_width_percent: remaining_width_percent }
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
      Turbo::StreamsChannel.broadcast_replace_to(
        "task_list",
        target: "status_bar",
        partial: "tasks/progress_bar",
        locals: { completed_width_percent: completed_width_percent, remaining_width_percent: remaining_width_percent }
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
      Turbo::StreamsChannel.broadcast_replace_to(
        "task_list",
        target: "status_bar",
        partial: "tasks/progress_bar",
        locals: { completed_width_percent: completed_width_percent, remaining_width_percent: remaining_width_percent }
      )
    end
  end


  def self.dom_id(record, prefix = nil)
    ActionView::RecordIdentifier.dom_id(record, prefix)
  end

  def self.completed_width_percent
    Task.where(status: "Completed").count.to_f / Task.count * 100
  end

  def self.remaining_width_percent
    100 - completed_width_percent
  end
end