class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:refresh]
  respond_to :js

  def refresh
    RefreshPostsJob.perform_later
  end
end
