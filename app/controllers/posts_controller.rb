class PostsController < ApplicationController
	before_action :find_post, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:index, :show] 

	def index
		@posts = Post.all.order("created_at DESC").paginate(page: params[:page], per_page: 3)
	end

	def recent
		@posts = Post.recent.paginate(page: params[:page], per_page: 3)
		render action: :index
	end

	def active
		@posts = Post.active.paginate(page: params[:page], per_page: 3)
		render action: :index
	end

	def unanswered
		@posts = Post.unanswered.paginate(page: params[:page], per_page: 3)
		render action: :index		
	end

	def show
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)	

		if @post.save
			redirect_to  @post
			flash[:notice] = "Post was successfully created!"
		else
			render 'new'
		end	
	end

	def edit
	end

	def update
		if @post.update(post_params) 
			redirect_to @post
		else
			render 'edit'
		end
	end

	def destroy
		@post.destroy
		redirect_to root_path
	end

	private

	def find_post
		@post = Post.find(params[:id])
	end

	def post_params
		params.require(:post).permit(:title, :content)
	end
end
