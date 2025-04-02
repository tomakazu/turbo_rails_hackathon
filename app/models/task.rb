class Task
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :description, type: String
  field :status, type: String

  after_create -> { TaskBroadcaster.broadcast_task(self, action: :create) }

end
