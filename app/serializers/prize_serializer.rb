class PrizeSerializer < BaseSerializer
  attributes :name, :prize_points
  belongs_to :course
end
