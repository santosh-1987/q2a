json.extract! question, :id, :question, :user_id, :tag_id, :created_at, :updated_at
json.url question_url(question, format: :json)