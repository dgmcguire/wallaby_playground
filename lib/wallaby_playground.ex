defmodule WallabyPlayground do
  use Wallaby.DSL
  require ExUnit.Assertions




  def run do

    {:ok, session} = Wallaby.start_session()

    # get into the website
    visit(session, "/")

    [elem] =
      session
      |> visit("/")
      |> find(
        Query.css("#password")
        |> Query.count(:any)
      )

    Element.fill_in(elem, with: "workinprogress")

    session
      |> find(Query.css("button[name=\"access_site\"][type=\"submit\"]"), fn(element) -> Element.click(element) end)

    session
      |> find(Query.css("a[href=\"/\"]"), fn(element) -> Element.click(element) end)

    #hover over helmet selector
    session
      |> find(Query.css("a.cmto-subheader__top-link[data-nid=\"9120\"][href=\"/motorcycle-helmets\"]"), fn(element) -> Element.hover(element) end)

    #click dual sport helm
    session
      |> find(Query.xpath("/html/body/div[2]/div[3]/div/div[1]/ul/li[1]/div/div/div[1]/div/ul/li[3]/a[1]/div/img"), fn(element) -> Element.click(element) end)

    # clickon adventure filter
    session
      |> find(Query.css("a.product-index-filters__facet-link.product-index-filters__facet-link--facet[data-facet-id=\"723\"][data-js=\"ProductCatalog.filterLink\"][href=\"#\"]"), fn(element) -> Element.click(element) end)

    #click on 50% off filter
    session
      |> find(Query.css("a.product-index-filters__facet-link.product-index-filters__facet-link--facet[data-discount-level=\"50\"][data-js=\"ProductCatalog.discountLink ProductCatalog.filterLink\"][href=\"#\"]"), fn(element) -> Element.click(element) end)

    Process.sleep(2000)

    #click on first element
    session
      |> find(Query.css("a.product-index-results__product-tile.product-tile[data-index=\"0\"]"), fn(element) -> Element.click(element) end)

    Process.sleep(5000)

    # assert that the chat exists
    IO.puts(ExUnit.Assertions.assert(has_css?(session, "#chat-widget-minimized")))

    # assert that the recommendations exist
    IO.puts(ExUnit.Assertions.assert(has_css?(session, ".product-show-component-section.product-show-component-section--related-products")))

    # obtains all colors into a list
    colors = Browser.all(session, Query.css("label.option-type__swatch-inner"))

    # picks second color if colors exist
    if length(colors) > 1 do
      [_first | [second | [ _third | _rest] ] ]  = colors
      Element.hover(second)
      move_mouse_by(session, 10, 10)
      Browser.double_click(session)
    else
      IO.puts("No colors to select")
    end

    # clicks option for extra small
    click(session, Query.option("XS"))

    # clicks add to cart button
    click(session, Query.button("Add to Cart"))

    # click to go to cart
    session
      |> find(Query.css("a.product-add-confirm__checkout-link.ui-link.ui-link--stacked[data-qa=\"view-cart\"][href=\"/cart\"]"), fn(element) -> Element.click(element) end)

    Process.sleep(1000)

    # test if join banner exists
    IO.puts(ExUnit.Assertions.assert(has_css?(session, "div.cart-show__clp-banner.cart-show__clp-banner--non-member")))


    # obtaining subtotal from the website as a string
    subtotalString =
      session
        |> find(Query.css("dd.line-item-summary__value[data-js=\"LineItemTable.subtotal.value\"]"))
        |> Element.text()


    # obtaining subtotal and making it a float
    {subtotal, _} =
      subtotalString
        |> String.replace("$", "")
        |> Float.parse()


    # checking if shipping is correctly free
    if subtotal > 69.99 do
      shippingString =
        session
          |> find(Query.css("dd.line-item-summary__value[data-js=\"LineItemTable.shippingTotal.value\"]"))
          |> Element.text()
      IO.puts(ExUnit.Assertions.assert(shippingString == "FREE!"))
    end

    click(session, Query.option("2"))

    # click proceed to checkout
    session
      |> find(Query.xpath("/html/body/div[3]/main/div[2]/div[4]/div/a"), fn(element) -> Element.click(element) end)

    # click checkout as guest
    session
    |> find(Query.xpath("/html/body/div[3]/main/div[2]/div[3]/div/a"), fn(element) -> Element.click(element) end)

    fill_in(session, Query.text_field("Last Name"), with: "Licopantest")

    fill_in(session, Query.text_field("Address Line 1"), with: "151 Garrett Street")

    fill_in(session, Query.text_field("Zip Code"), with: "07843")

    fill_in(session, Query.text_field("City"), with: "Astoria")

    click(session, Query.option("New Jersey"))

    fill_in(session, Query.text_field("Phone Number"), with: "9738794242")

    fill_in(session, Query.text_field("Email Address"), with: "peter.licopantis@revzilla.com")

    fill_in(session, Query.text_field("First Name"), with: "Peter")

    Process.sleep(1000)

    [ button1 | _button2 ] = Browser.all(session, Query.button("Continue"))
    Element.hover(button1)
    move_mouse_by(session, 10, 10)
    Browser.double_click(session)

    IO.puts(selected?(session, Query.xpath("/html/body/div[3]/main/form/div/div/div[3]/div/div[1]/div[2]/div/input[1]")))

    #click(page, Query.radio_button("Radio Button 1"))

    Process.sleep(1000)

    session
      |> Wallaby.Browser.take_screenshot()

  end
 end
