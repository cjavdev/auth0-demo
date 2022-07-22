class CreateSites < ActiveRecord::Migration[7.1]
  def change
    create_table :sites do |t|
      t.string :subdomain
      t.string :name
      t.string :background_color
      t.string :primary_color
      t.string :auth0_org_id

      t.timestamps
    end
  end
end
