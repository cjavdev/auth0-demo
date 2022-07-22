class SubdomainConstraint
  def matches?(request)
    Site.where(subdomain: request.subdomain).exists?
  end
end
