class ApplicationController < ActionController::Base
  protect_from_forgery

  # Up top make it visible in the views.
  helper_method :show_hash

  private
  
  def show_hash(hash)
    str = "<pre>\n"
    hash.sort.each { |k, v| str << sprintf("%-20s %s\n", k, v.inspect) }
    str << "</pre>"
    str.html_safe
  end
end
