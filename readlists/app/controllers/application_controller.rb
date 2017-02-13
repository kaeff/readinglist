require 'net/http/post/multipart'

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def send_ebook(locals, type, filename)
    send_data ebook_convert(type, locals), filename: filename, type: type
  end

  def ebook_convert(format, locals)
    file = render_to_string("show", formats: [:html], locals: locals)
    url = URI.parse('http://calibre:3000/calibre/ebook-convert')
    req = Net::HTTP::Post::Multipart.new url.path,
      file: UploadIO.new(StringIO.new(file), "application/html", "article.html"),
      to: format
    res = Net::HTTP.start(url.host, url.port) do |http|
      http.request(req)
    end
    res.body
  end

end
