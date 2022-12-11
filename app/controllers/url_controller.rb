class UrlController < ApplicationController
  def index
  end

  def show
    @url = Url.find(params[:id])
    length = 5
    url_extension = ([*('A'..'Z'),*(@url.id)]-%w(I O)).sample(length).join
    @short_url = "http://localhost:3000/#{url_extension}"
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      redirect_to @url
    else
      redirect_to 'url/index'
    end
  end

  def redirect_url
    id = params[:short_url].tr("^0-9","")
    url = Url.find(id)
    redirect_to link.input_url
  end

  private

  def url_params
    params.require(:url).permit(:input_url)
  end
end
