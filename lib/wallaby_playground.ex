defmodule WallabyPlayground do
  use Wallaby.DSL

  def run do
    class = ".cmto-subheader__top-link"
    # class = ".ui-button--large"

    {:ok, session} = Wallaby.start_session()
    [elem | _rest] =
      session
      |> visit("/")
      |> find(
        Query.css(class)
        |> Query.count(:any)
      )


    session = Wallaby.Element.click(elem)

    session
    |> Wallaby.Browser.take_screenshot()

    #
    # session
    # |> find(Query.css(".shop-by__heading-text", count: 3))
    #
    # session
    # |> Wallaby.Browser.take_screenshot()
  end
end
