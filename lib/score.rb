class Score
  def self.calculate(votes, prior=[2, 2, 2, 2, 2])
    posterior = votes.zip(prior).map { |a, b| a + b }
    sum = posterior.inject { |a, b| a + b }
    posterior.
      map.with_index { |v, i| (i + 1) * v }.
      inject { |a, b| a + b }.
      to_f / sum
  end
end
