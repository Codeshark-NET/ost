class IssuesController < ApplicationController
  def index
    scope = Issue.where(pull_request: false, state: 'open')

    if params[:sort].present? || params[:order].present?
      sort = params[:sort].presence || 'created_at'
      if params[:order] == 'asc'
        scope = scope.order(Arel.sql(sort).asc.nulls_last)
      else
        scope = scope.order(Arel.sql(sort).desc.nulls_last)
      end
    else
      scope = scope.order('created_at DESC')
    end

    @pagy, @issues = pagy(scope)
  end
end