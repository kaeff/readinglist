require 'json'
require 'net/http/post/multipart'

class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    respond_to do |format|
      format.html { render locals: { article: article }
      format.epub { send_ebook(@article, :epub, filename: "#{@article.slug}.epub" }
      format.mobi { send_ebook(@article, :mobi, filename: "#{@article.slug}.mobi" }
    end
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    response  = RestClient.get 'http://scraper:3000/api/get', { params: { url: @article.url } }
    scraped_article = JSON.parse(response.body)
    @article.update({
      :title => scraped_article['title'],
      :byline => scraped_article['byline'],
      :excerpt => scraped_article['excerpt'],
      :content_html => scraped_article['content'],
      :readerable => scraped_article['readerable'],
      :scraped_at => DateTime.now
    })

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:url, :title, :byline, :excerpt, :readerable, :scraped_at, :content_html)
    end
end
