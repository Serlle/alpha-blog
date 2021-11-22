class ArticlesController < ApplicationController
	def index
		@article = Article.all
	end

	def	show
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(params.require(:article).permit(:title, :description))
		#render plain: @article.inspect #Sirve para inspeccionar a detalle el objeto creado
		if @article.save
			flash[:notice] = "Article was created successfully."
			redirect_to @article
		else
			render 'new'
		end
	end

	def edit
		@article = Article.find(params[:id])
	end

	def update
    @article = Article.find(params[:id])
    if @article.update(params.require(:article).permit(:title, :description))
      flash[:notice] = "Article was created successfully."
      redirect_to @article
    else
      render 'edit'
    end
	end
end