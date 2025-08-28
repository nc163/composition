# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @resources = User.all
  end

  def show
    @resource = User.find(params[:id])
  end
end
