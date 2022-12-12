class UrlController < ApplicationController
  def index
    @url = Url.new
    @urls = Url.all
  end

  def new
    @urls = Url.all
  end

  def show
    @url = Url.find(params[:id])
    length = 5
    url_extension = ([*('A'..'Z'),*('0'..'9')]-%w(I O)).sample(length).join
    @short_url = "http://localhost:3000/#{url_extension}"
    @url.update_attribute(:clicked, @url.clicked + 1)
    @url.short_url = @short_url
    @url.save!
  end

  def create
    @url = Url.new(url_params)
    if @url.save
      redirect_to url_path(@url.id), notice: "Url successfully created."
    else
      render action: 'new'
    end
  end

  def redirect_url
    Url.find_each do |u|
      if u.short_url.split('/')[-1] == params[:short_url] 
        @id = u.id
      end
      if @id.present?
        url = Url.find(@id).input_url
        url_regex = Regexp.new("((https?|ftp|file):((//)|(\\\\))+[\w\d:\#@%/;$()~_?\+-=\\\\.&]*)")
        domain = 'http://'
        if url =~ url_regex then
          redirect_to url
        else
          redirect_to domain.concat(url)
        end
      end
    end
  end

  private

  def url_params
    params.require(:url).permit(:input_url)
  end
end
