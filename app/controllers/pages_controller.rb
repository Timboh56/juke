class PagesController < ApplicationController
  filter_resource_access

  def generic
    respond_to do |format|
      format.html
    end
  end

  def legal
    generic
  end

  def index

  end
  
  def main

  end
end