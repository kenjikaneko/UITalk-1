# -*- coding: utf-8 -*-

# t.integer "comment_id"
# t.integer "user_id"
# t.string  "kind"
# t.boolean "available"

class CommentEvaluation < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment

  attr_accessible :available, :comment_id, :kind, :user_id

  validate :kind_valid?

  default_scope where(available: true)
  scope :good, where(kind: 1)
  scope :bad, where(kind: 2)

  def kind_list
    # "1": good
    # "2": bad
    [ 1, 2 ]
  end

private
  def include_by_kind?
    kind_list.include? kind
  end

  def kind_valid?
    errors.add(:kind, 'kindが不正') unless include_by_kind?
  end

end