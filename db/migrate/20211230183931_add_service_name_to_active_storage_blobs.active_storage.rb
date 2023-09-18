# frozen_string_literal: true

# This migration comes from active_storage (originally 20190112182829)
class AddServiceNameToActiveStorageBlobs < ActiveRecord::Migration[6.0]
  def up
    add_column :active_storage_blobs, :service_name, :string

    configured_service = ActiveStorage::Blob.service.name
    if configured_service
      ActiveStorage::Blob.unscoped.find_each do |blob|
        blob.update!(service_name: configured_service)
      end
    end

    safety_assured do
      change_column :active_storage_blobs, :service_name, :string, null: false
    end
  end

  def down
    remove_column :active_storage_blobs, :service_name
  end
end
