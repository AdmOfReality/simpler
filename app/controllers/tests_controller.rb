class TestsController < Simpler::Controller

  def index
    @tests = Test.all
    @time = Time.now

    # render plain: "Plain text response"
    render json: { message: "Plain text response", time: Time.now }
  end

  def create

  end

end
