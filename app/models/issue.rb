class Issue < ApplicationRecord
  belongs_to :project

  scope :label, ->(labels) { where("labels && ARRAY[?]::varchar[]", labels) }
  scope :sustainfest, -> { label(["sustainfest", 'help wanted', 'good first issue','hacktoberfest']) }
  scope :good_first_issue, -> { sustainfest.where(pull_request: false, state: 'open').where('issues.created_at > ?', 1.year.ago)  }

  def old_labels
    JSON.parse(labels_raw)
  end

  def labels
    self[:labels].presence || old_labels
  end

  def update_labels
    update(labels: old_labels) if old_labels.present?
  end
end
