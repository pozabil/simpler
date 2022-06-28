class TestsController < Simpler::Controller

  def index
    @time = Time.now
    status 256
    headers['Test-Header-Game'] = 'make u smile'
    headers['Content-Type'] = 'text/plain'
    render 'tests/list'
  end

  def create

  end

  def show
    @id = params[:id]
    render plain: "Privet, ya test #{@id}! Kak u tebya dela?"
  end
end
