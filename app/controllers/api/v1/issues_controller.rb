class Api::V1::IssuesController < Api::V1::ApplicationController
  def index
    scope = Issue.where(pull_request: false, state: 'open').includes(:project)
    scope = scope.joins(:project).where(projects: { reviewed: true }).sustainfest
    scope = scope.where('issues.created_at > ?', 1.year.ago) 

    if params[:sort].present? || params[:order].present?
      sort = params[:sort].presence || 'issues.created_at'
      if params[:order] == 'asc'
        scope = scope.order(Arel.sql(sort).asc.nulls_last)
      else
        scope = scope.order(Arel.sql(sort).desc.nulls_last)
      end
    else
      scope = scope.order('issues.created_at DESC')
    end

    @pagy, @issues = pagy(scope)
  end

  def sustainfest
    project_ids = Issue.good_first_issue.pluck(:project_id).uniq

    scope = Project.where(id: project_ids).reviewed.includes(:sustainfest_issues)

    if params[:sort].present? || params[:order].present?
      sort = params[:sort].presence || 'projects.updated_at'
      if params[:order] == 'asc'
        scope = scope.order(Arel.sql(sort).asc.nulls_last)
      else
        scope = scope.order(Arel.sql(sort).desc.nulls_last)
      end
    else
      scope = scope.order('projects.updated_at DESC')
    end

    @pagy, @projects = pagy(scope)
  end
end
