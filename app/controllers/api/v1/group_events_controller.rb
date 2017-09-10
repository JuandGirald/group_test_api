module Api::V1
  class GroupEventsController < ApiController
    include Api::V1::GroupEventsDoc
    include ErrorSerializer
    before_action :set_group_event, only: [:show, :update, :destroy]

    # GET /group_events
    # query? "published, draft, deleted, all, all_events"
    def index
      if params[:query].present?
        @events = GroupEvent.send(params[:query])
      else
        @events = GroupEvent.published
      end

      render json: @events
    end

    # GET /group_events/1
    def show
      render json: @event
    end

    # POST /group_events
    def create
      @event = GroupEvent.new(group_event_params)

      if @event.save
        render json: @event
      else
        render json: ErrorSerializer.serialize(@event.errors), status: :unprocessable_entity
      end
    end

    # PATCH/PUT /group_events/1
    def update
      if @event.update(group_event_params)
        render json: @event
      else
        render json: ErrorSerializer.serialize(@event.errors), status: :unprocessable_entity
      end
    end

    def destroy
      if @event.destroy
        render json: @event
      else
        render json: ErrorSerializer.serialize(@event.errors), status: :unprocessable_entity
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_group_event
        @event = GroupEvent.find(params[:id])
      end

      def group_event_params
        params.require(:group_event).permit(:id, :start_date, :duration, :location, 
                                            :name, :description, :status, :end_date)
      end
  end
end