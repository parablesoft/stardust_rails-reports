class StardustRails::Reports::Configuration

  def manager_roles=(value)
    @manager_roles = value
  end

  def manager_roles
    @manager_roles || []
  end
end
