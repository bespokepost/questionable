module Questionable
  # Inherit from ActionController::Base so that we avoid running unwanted before_ and after_ hooks
  class ApplicationController < ActionController::Base
  end
end
