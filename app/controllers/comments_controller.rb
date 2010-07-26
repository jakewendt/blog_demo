class CommentsController < ApplicationController
  before_filter :get_post
  before_filter :login_required #, :except => [ :index, :show ]
  before_filter :check_comment_owner, :only => [ :edit, :update, :destroy ]

  def edit
  end

  def create
    @comment = @post.comments.new(params[:comment])
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        flash[:notice] = 'Comment was successfully created.'
        format.html { redirect_to(post_path(@post)) }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Comment was successfully updated.'
        format.html { redirect_to(post_path(@post)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to(post_path(@post)) }
      format.xml  { head :ok }
    end
  end

protected

  def get_post
    @post = Post.find(params[:post_id])
  end

  def check_comment_owner
    @comment = @post.comments.find(params[:id])
    unless ( @comment.user == current_user ) || current_user.has_role?('administrator')
      permission_denied
    end
  end

end
