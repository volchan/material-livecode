class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def show
    @post = Post.find(params[:id])
  end
end
