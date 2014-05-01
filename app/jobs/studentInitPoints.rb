class StudentInitPoints
  @queue = :student_points_queue

  def self.perform(prev_term)
    StudentPointsController.calcInitPoints(prev_term)
  end
end