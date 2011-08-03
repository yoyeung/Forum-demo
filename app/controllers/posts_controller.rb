class PostsController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :find_board
  
  # GET /posts
  # GET /posts.xml
  def index
    redirect_to board_path(@board)
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
   @board = find_board
   @post =@board.posts.find(params[:id])
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = @board.posts.build
  end

  # GET /posts/1/edit
  def edit
    @post = current_user.posts.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = @board.posts.build(params[:post])
    @post.user_id = current_user.id
    respond_to do |format|
      if @post.save
        format.html { redirect_to(board_posts_path, :notice => 'Post was successfully created.') }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update

    @post = current_user.posts.find(params[:id])
    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to(board_post_path(@board,@post), :notice => 'Post was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    
    respond_to do |format|
      format.html { redirect_to(board_posts_path(@board)) }
      format.xml  { head :ok }
    end
  end
  
  
  protected
   def find_board
     @board =Board.find(params[:board_id])
   end
  
  
end
