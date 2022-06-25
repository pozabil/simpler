class TestsController < Simpler::Controller

  def index
    @time = Time.now
    status 256
  end

  def create

  end

end
