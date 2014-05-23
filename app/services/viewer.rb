class Viewer
  def initialize(user, cookies)
    @user = user
    @cookies = cookies
  end

  def visits(resource)
    return false unless can_visit(resource)
    save_view(resource)
    resource.update_views!
  end

protected
  def can_visit(resource)
    !@cookies[resource.id]
  end

  def save_view(resource)
    @cookies[resource.id] = { value: 1, expires: 24.hours.from_now } unless @cookies[resource.id]
  end
end
