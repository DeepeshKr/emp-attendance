class Attendance < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :for_date, presence: true
  validates :in_time, presence: true

  def self.add_new_day user_id
    attendace = Attendance.create(user_id: user_id, for_date: DateTime.now.to_date, in_time:DateTime.now)
    return "You attendace is marked for #{attendace.in_time.strftime("%H:%M %p ")}, and you are #{attendace.on_time[1]}"
  end
  
  def on_time
   if self.in_time.hour.to_i >= 10 
       return ["table-danger", "Late"]
   end
  return ["table-success", "On Time"] 
  end
end
