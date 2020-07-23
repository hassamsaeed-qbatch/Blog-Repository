class ArticlesController < ApplicationController
    http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]
    
    def index
        # Nested Params
        # @articles = Article.all
        @article = Article.all
        # check the string query params when the user status is activated
        # if params[:status] == "activated"
        # @articles = Article.all
        # end
    end
    def show
        @article = Article.find(params[:id])
    end
    def new
        # Nested Params
        #@article = Article.new
        #@article.comments.build

        @article = Article.new
        
        # Serialization
        json = { name: 'Bob' }.to_json
        person = Person.new
        person.from_json(json) # => #<Person:0x00000100c773f0 @name="Bob">
        puts person.name

    end
    def edit
        @article = Article.find(params[:id])
    end
    def create
        # Nested Params
        #=begin
        #@article = Article.new(article_params)
        
        #byebug
        #if @article.save

        #     redirect_to @article
        #else
        #     render 'new'
        #end

        @article = Article.new(article_params)
 
         if @article.save
            redirect_to @article
         else
             render 'new'
         end    
    end
    def update
        @article = Article.find(params[:id])
        if @article.update(article_params)
            redirect_to @article
        else
            render 'edit'
        end
    end
    def destroy
        @article = Article.find(params[:id])
        @article.destroy
       
        redirect_to articles_path
      end

    def showjson
        params.permit!
        render plain: "The parameter is set as #{params[:article].as_json}"
    end
    private
      #def article_params
      #params.require(:article).permit(:title, :text, comments_attributes: [:commenter, :body])
      #end
    def article_params
            params.require(:article).permit(:title, :text)
     end
end
