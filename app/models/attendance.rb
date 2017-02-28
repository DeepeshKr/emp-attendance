class Attendance < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :for_date, presence: true
  validates :in_time, presence: true
  after_create :update_if_late
  
  def self.add_new_day user_id
    attendance = Attendance.create(user_id: user_id, for_date: DateTime.now.to_date, in_time:DateTime.now)
    
    return "You attendace is marked for #{attendance.in_time.strftime("%H:%M %p ")}, and you are #{attendance.on_time[1]}"
  end
  
  def self.close_day user_id
    attendances = Attendance.where(user_id: user_id, for_date: DateTime.now.to_date)
                  .where("out_time is null")
                .order(in_time: :desc)
                # 
    return "No in date for today or already punched out!" if attendances.blank?
    attendance = attendances.first
    elapsed_hours = TimeDifference.between(attendance.in_time, DateTime.now).in_hours
    # elapsed_hours = (attendance.in_time.to_i - DateTime.now.to_i) / 360
    attendance.update(out_time: DateTime.now, hours_worked: elapsed_hours)
    return "You worked for #{elapsed_hours} hours today"
  end
  
  def on_time
   if self.in_time.hour.to_i >= 10 
       return ["table-danger", "Late"]
   end
    return ["table-success", "On Time"] 
  end
  
  private
  
  def update_if_late
    if self.in_time.hour.to_i >= 10 
      self.update(forced_leave: true)
    end
  end
  
end
