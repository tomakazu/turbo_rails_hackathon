class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :description, type: String
  field :status, type: String

  after_create -> {
    TaskBroadcaster.broadcast_task(self, action: :create)
    NotificationService.notify_new_task(self)
  }
  after_update -> { TaskBroadcaster.broadcast_task(self, action: :update) }
  after_destroy -> { TaskBroadcaster.broadcast_task(self, action: :destroy) }

end
