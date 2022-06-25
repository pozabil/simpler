class TestsController < Simpler::Controller

  def index
    @time = Time.now
    status 256
    headers['Test-Header-Game'] = 'make u smile'
    headers['Content-Type'] = 'text/plain'
  end

  def create

  end

end
