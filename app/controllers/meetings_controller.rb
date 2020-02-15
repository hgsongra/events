class MeetingsController < ApplicationController
  before_action :set_meeting, only: [:show, :edit, :update, :destroy, :attend, :unattend]
  before_action :authenticate_user!, except: [:show, :index]

  # GET /meetings
  # GET /meetings.json
  def index
    @meetings = Meeting.all.order(:created_at).page(params[:page])
  end

  # GET /meetings/1
  # GET /meetings/1.json
  def show
  end

  # GET /meetings/new
  def new
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings
  # POST /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: 'Meeting was successfully created.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1
  # PATCH/PUT /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: 'Meeting was successfully updated.' }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1
  # DELETE /meetings/1.json
  def destroy
    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: 'Meeting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def attend
    return redirect_to @meeting, notice: 'Event already complete!.' if @meeting.past?
    
    invite = @meeting.invites.new(user: current_user)
    respond_to do |format|
      if invite.save
        format.html { redirect_to @meeting, notice: 'You\'re going to this event!.' }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new }
        format.json { render json: invite.errors, status: :unprocessable_entity }
      end
    end
  end

  def unattend
    return redirect_to @meeting, notice: 'Event already complete!.' if @meeting.past?
    @meeting.invites.where(user: current_user).destroy_all
    respond_to do |format|
      format.html { redirect_to @meeting, notice: 'You widthraw from going to this event!.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.require(:meeting).permit(:title, :description, :start_at, :end_at)
    end

end
