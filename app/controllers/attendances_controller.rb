class AttendancesController < ApplicationController
  before_action :set_attendance, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /attendances
  # GET /attendances.json
  def index
    @from_date = Date.today
    @to_date = Date.today
    
    if (params.has_key?(:from) && params.has_key?(:upto))
      @from_date = Date.new(params[:from][:year].to_i, params[:from][:month].to_i,params[:from][:day].to_i) 
      @to_date = Date.new(params[:upto][:year].to_i, params[:upto][:month].to_i, params[:upto][:day].to_i)
      @attendances = Attendance.where("for_date >= ? and for_date <= ?", @from_date, @to_date)
      .order(:in_time).page params[:page]
    else
      @attendances = Attendance.all.order(:in_time).page params[:page]
    end
    
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    @attendance = Attendance.new
  end

  # GET /attendances/1/edit
  def edit
  end
  
  def add_today
      # flash[:danger] = "Alerting you to the monkey on your car!"
      message = Attendance.add_new_day current_user.id
      redirect_to current_user, flash: {success: "#{message}"}
  end
  # POST /attendances
  # POST /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to @attendance, notice: 'Attendance was successfully created.' }
        format.json { render :show, status: :created, location: @attendance }
      else
        format.html { render :new }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
    respond_to do |format|
      if @attendance.update(attendance_params)
        format.html { redirect_to @attendance, notice: 'Attendance was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: 'Attendance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.require(:attendance).permit(:user_id, :for_date, :in_time, :out_time, :forced_leave, :leave_granted, :hours_worked, :break_hours)
    end
end
