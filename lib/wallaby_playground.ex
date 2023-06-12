defmodule WallabyPlayground do
  use Wallaby.DSL

  def run do
    {:ok, session} = Wallaby.start_session()
    result = session
      |> visit("/")
      |> find(Query.css(".ui-button--large", count: 2))

  click(session, result)
  end
end
