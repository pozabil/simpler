class MoneyController < Simpler::Controller

  def index
    @time = Time.now
    status 256
    headers['Test-Header-Game'] = 'u are rich'
  end

  def create

  end

  def show
    @number = params[:number]
  end

end
