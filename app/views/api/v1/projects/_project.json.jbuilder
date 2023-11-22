json.extract! project, :id, :url, :last_synced_at, :repository, :owner, :packages, :commits, :issues_stats, :events, :keywords, :dependencies, :score, :created_at, :updated_at, :avatar_url, :language
json.project_url api_v1_project_url(project, format: :json)
json.html_url project_url(project)
