module MyGenieApp

using Logging, LoggingExtras

function main()
  Base.eval(Main, :(const UserApp = MyGenieApp))

  include(joinpath("..", "genie.jl"))

  Base.eval(Main, :(const Genie = MyGenieApp.Genie))
  Base.eval(Main, :(using Genie))
end; main()

end
