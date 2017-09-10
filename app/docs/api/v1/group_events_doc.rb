module Api::V1::GroupEventsDoc
  extend BaseDoc

  namespace 'api/v1'
  resource :group_events

  doc_for :index do
    api :GET, '/group_events/', 'Display all group events'
    param :query, String, "'Published' by default. Should be: 'draft', 'deleted' or 'published'"
  end

  doc_for :show do
    api :GET, '/group_event/:id', 'Display a group event'
    param :id, Integer, :required => true
  end

  doc_for :create do
    api :POST, '/group_events', 'Create a group event. When all fields are present, 
                                the event will be published, if not, will save as a draf(if at least one field present))'
    param :group_event, Hash, :desc => "Group Event info", :required => true do
      param :name, String, :required => true
      param :start_date, Date, :required => true
      param :end_date, Date, :required => true
      param :duration, Integer, :required => true
      param :location, String, :required => true
      param :description, String, :required => true
    end
  end

  doc_for :update do
    api :PUT, '/group_events/:id', 'Update a group event'
    param :id, Integer, :required => true
    param :group_event, Hash, :desc => "Group Event info", :required => true do
      param :name, String, :required => false
      param :start_date, Date, :required => false
      param :end_date, Date, :required => false
      param :duration, Integer, :required => false
      param :location, String, :required => false
      param :description, String, :required => false
    end
  end

  doc_for :delete do
    api :DELETE, '/group_events/:id', 'Delete a group event'
    param :id, Integer, :required => true
  end
end