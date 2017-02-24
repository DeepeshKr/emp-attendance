json.extract! attendance, :id, :user_id, :for_date, :in_time, :out_time, :forced_leave, :leave_granted, :hours_worked, :break_hours, :created_at, :updated_at
json.url attendance_url(attendance, format: :json)
