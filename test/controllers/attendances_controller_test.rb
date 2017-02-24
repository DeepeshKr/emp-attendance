require 'test_helper'

class AttendancesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @attendance = attendances(:one)
  end

  test "should get index" do
    get attendances_url
    assert_response :success
  end

  test "should get new" do
    get new_attendance_url
    assert_response :success
  end

  test "should create attendance" do
    assert_difference('Attendance.count') do
      post attendances_url, params: { attendance: { break_hours: @attendance.break_hours, for_date: @attendance.for_date, forced_leave: @attendance.forced_leave, hours_worked: @attendance.hours_worked, in_time: @attendance.in_time, leave_granted: @attendance.leave_granted, out_time: @attendance.out_time, user_id: @attendance.user_id } }
    end

    assert_redirected_to attendance_url(Attendance.last)
  end

  test "should show attendance" do
    get attendance_url(@attendance)
    assert_response :success
  end

  test "should get edit" do
    get edit_attendance_url(@attendance)
    assert_response :success
  end

  test "should update attendance" do
    patch attendance_url(@attendance), params: { attendance: { break_hours: @attendance.break_hours, for_date: @attendance.for_date, forced_leave: @attendance.forced_leave, hours_worked: @attendance.hours_worked, in_time: @attendance.in_time, leave_granted: @attendance.leave_granted, out_time: @attendance.out_time, user_id: @attendance.user_id } }
    assert_redirected_to attendance_url(@attendance)
  end

  test "should destroy attendance" do
    assert_difference('Attendance.count', -1) do
      delete attendance_url(@attendance)
    end

    assert_redirected_to attendances_url
  end
end
