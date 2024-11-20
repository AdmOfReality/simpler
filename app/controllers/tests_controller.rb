class TestsController < Simpler::Controller

  def index
    @tests = Test.all
    @time = Time.now

    # render plain: "Plain text response"
    render json: { message: "Plain text response", time: Time.now }
    status 201
    headers['custom-header'] = 'It is HEADERS'
  end

  def show
    @id = params[:id]
  end

  def create

  end

end
