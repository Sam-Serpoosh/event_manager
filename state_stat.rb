class StateStats
  def initialize
    @state_stats = {}
  end

  def update_state_stats(state)
    return if state.nil?
    state = state.to_sym
    if @state_stats.has_key?(state)
      @state_stats[state] += 1 
    else
      @state_stats[state] = 1
    end
  end

  def attendees_from(state)
    @state_stats[state] || 0
  end

  def stats
    ranks = @state_stats.sort_by { |state, counter| -counter }
                        .collect { |state, counter| state }
    @state_stats = @state_stats.sort_by { |state, counter| state }
    @state_stats.map do |state, counter|
      "#{state}\t#{counter}\t(#{ranks.index(state) + 1})"
    end
  end
end
