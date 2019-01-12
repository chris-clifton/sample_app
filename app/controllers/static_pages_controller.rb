class StaticPagesController < ApplicationController
  def home
    render html: "this should be the home page"
  end

  def help
    render html: "this should be the help page"
  end
end
