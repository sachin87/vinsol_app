module ApplicationHelper
  
  def full_title(page_title)
    base_title = "Vinsol App"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def current_user?(user)
    current_user == user
  end

end
