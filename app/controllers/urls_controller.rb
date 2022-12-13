class UrlsController < ApplicationController
  def index
    @url = Url.new
    @urls = Url.all
  end

  def new
    @urls = Url.all
  end

  def show
    @url = Url.find(params[:id])
  end

  def create
    @url = Url.new(url_params)
    length = 5
    url_extension = ([*('A'..'Z'),*('0'..'9')]-%w(I O)).sample(length).join
    @short_url = "http://localhost:3000/#{url_extension}"
    @url.update_attribute(:clicked, @url.clicked + 1)
    @url.short_url = @short_url
    @url.save
    respond_to do |format|
      if @url.save
        format.html { redirect_to root_path, notice: 'Url was successfully created.' }
        format.js
        format.json { render json: @url, status: :created, location: @url }
      else
        format.html { render action: "new" }
        format.json { render json: @url.errors, status: :unprocessable_entity }
      end
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
          return redirect_to(url)
        else
          return redirect_to(domain.concat(url))
        end
      end
    end
  end

  private

  def url_params
    params.require(:url).permit(:input_url)
  end
end
