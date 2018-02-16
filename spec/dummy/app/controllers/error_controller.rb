class ErrorController < ApplicationController
  def error
    raise "something"
  end
end
