# frozen_string_literal: true

class CommentsController < ApplicationController
  def index
    @resources = Comment.all
  end

  def show
    @resource = Comment.find(params[:id])
  end
end
