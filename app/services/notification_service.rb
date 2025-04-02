class NotificationService
  def self.notify_new_task(task)
    Turbo::StreamsChannel.broadcast_replace_to("task_list",
      target: "new_task_created",
      
    )
  end

  def self.notify_task_updated(task)
    # Logic to send notification about the updated task
    puts "Task updated: #{task.title}"
  end

  def self.notify_task_destroyed(task)
    # Logic to send notification about the destroyed task
    puts "Task destroyed: #{task.title}"
  end
end