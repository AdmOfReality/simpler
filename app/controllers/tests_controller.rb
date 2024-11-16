class TestsController < Simpler::Controller

  def index
    @tests = Test.all
    @time = Time.now
  end

  def create

  end

end
