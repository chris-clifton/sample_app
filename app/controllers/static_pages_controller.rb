class StaticPagesController < ApplicationController
  def home
    @page_title = 'Home'
    #render html: "this should be the home page"
  end

  def help
    @page_title = 'Help'
    # render html: "this should be the help page"
  end

  def about
     @page_title = 'About'
  end
end
