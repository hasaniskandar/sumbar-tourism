class EventsController < ApplicationController
  load_and_authorize_resource
  impressionist
  # GET /events
  # GET /events.json
  def index
    #    @events = Event.all
    #    @events = Event.order("created_at DESC").page(params[:page]).per(10)
    @events = @events.published.recent.page(params[:page]).per(10).accessible_by(current_ability)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  def like
    @like = current_user.likes.new(params[:like])
    @like.likeable = @event

    if @like.save
      redirect_to @event
    else
      render action: "show"
    end
  end
  # GET /events/1
  # GET /events/1.json
  def show
    #    @event = Event.find(params[:id])
    @comments = @event.comments.published.recent.page(params[:page]).per(10)
    @comment = Comment.new
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  def create_comment
    #    @event = Event.find(params[:id])
    @comment = current_user.comments.new(params[:comment])
    @comment.commentable = @event
    
    if @comment.save
      redirect_to @event
    else
      render action: "show"
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    #    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    #    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
    #    @event = current_user.events.new(params[:event])
    
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    #    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    #    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
