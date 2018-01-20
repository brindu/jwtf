module JWTF
  class Period
    def initialize(period)
      @period = period
    end

    # @period argument needs to be a hash of this kind :
    # { months: 2, weeks: 3, ... }
    def in_seconds
      @period.reduce(0) do |total_seconds, (period, nb_period)|
        total_seconds + (nb_period * self.send(period))
      end
    end

    private

    def seconds; 1; end
    alias :second :seconds

    def minutes; 60; end
    alias :minute :minutes

    def hours; 3600; end
    alias :hour :hours

    def days; 86_400; end
    alias :day :days

    def weeks; 604_800; end
    alias :week :weeks

    def months; 2_592_000; end # 30 days
    alias :month :months

    def years; 31_557_600; end # 365,25 days
    alias :year :years
  end
end
