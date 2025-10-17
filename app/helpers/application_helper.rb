module ApplicationHelper
  def admin_badge_for(user)
    if user.admin?
      content_tag(:span, "👑 Admin", class: "badge badge-admin")
    end
  end
  
  def page_title(title)
    content_for :title, "#{title} - Reading Challenge"
  end
end
