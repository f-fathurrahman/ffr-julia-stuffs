type LSD
  pounds::Int
  shillings::Int
  pence::Int

  # (inner) constructor
  function LSD(a,b,c)
    if a < 0 || b < 0 || c < 0
      error("no negative numbers")
    end
    if c > 12 || b > 20
      error("too many pence or shillings")
    end
    # create new objects with the passed-in values
    new(a, b, c)
  end
end


