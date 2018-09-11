json.extract! profile, :id, :nombre, :apellido, :dinero, :created_at, :updated_at
json.url profile_url(profile, format: :json)
