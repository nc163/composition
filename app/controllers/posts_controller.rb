# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @page, @resources = pagy Post.all
  end

  def show
    @resource = Post.find(params[:id])
  end
end
