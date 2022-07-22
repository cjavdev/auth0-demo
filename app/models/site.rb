# == Schema Information
#
# Table name: sites
#
#  id               :bigint           not null, primary key
#  subdomain        :string
#  name             :string
#  background_color :string
#  primary_color    :string
#  auth0_org_id     :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Site < ApplicationRecord

  after_commit :ensure_auth0_org_id

  def ensure_auth0_org_id
    return if auth0_org_id.present?
    org = auth0_client.create_organization(
      name: subdomain,
      display_name: name,
      branding: {
        colors: {
          primary: primary_color,
          page_background: background_color
        }
      },
      enabled_connections: connections
    )
    update(auth0_org_id: org['id'])
  end

  def connections
    auth0_client.connections.map {|c| { connection_id: c['id'], assign_membership_on_login: true }}
  end

  def members
    auth0_client.get_organizations_members(auth0_org_id)
  end

  def auth0_client
    @auth0_client ||= Auth0Client.new(
      client_id: Rails.application.credentials.auth0[:m2m_client_id],
      client_secret: Rails.application.credentials.auth0[:m2m_client_secret],
      domain: Rails.application.credentials.auth0[:domain],
      api_version: 2,
      timeout: 15 # optional, defaults to 10
    )
  end
end
