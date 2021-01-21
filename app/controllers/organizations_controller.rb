class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.includes(:jobs).order(name: :asc)
    @jobs = @organizations.map(&:jobs)
  end
end
