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
    @state_stats.map do |key, value|
      "#{key.to_s}: #{value}"
    end
  end
end
