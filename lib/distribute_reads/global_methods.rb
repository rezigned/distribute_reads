module DistributeReads
  module GlobalMethods
    def distribute_reads(max_lag: nil)
      if max_lag && DistributeReads.lag > max_lag
        raise DistributeReads::TooMuchLag, "Replica lag over #{max_lag} seconds"
      end

      previous_value = Thread.current[:distribute_reads]
      begin
        Thread.current[:distribute_reads] = true
        yield
      ensure
        Thread.current[:distribute_reads] = previous_value
      end
    end
  end
end
