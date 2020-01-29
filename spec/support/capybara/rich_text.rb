# frozen_string_literal: true

# This module can be removed once it makes it into a Rails release

module ActionText
  module SystemTestHelper
    # Locates a Trix editor and fills it in with the given HTML.
    #
    # The editor can be found by:
    # * its +id+
    # * its +placeholder+
    # * its +aria-label+
    # * the +name+ of its input
    #
    # Examples:
    #
    #   # <trix-editor id="message_content" ...></trix-editor>
    #   fill_in_rich_text_area "message_content", with: "Hello <em>world!</em>"
    #
    #   # <trix-editor placeholder="Your message" ...></trix-editor>
    #   fill_in_rich_text_area "Your message", with: "Hello <em>world!</em>"
    #
    #   # <trix-editor aria-label="Message content" ...></trix-editor>
    #   fill_in_rich_text_area "Message content", with: "Hello <em>world!</em>"
    #
    #   # <input id="trix_input_1" name="message[content]" type="hidden">
    #   # <trix-editor input="trix_input_1"></trix-editor>
    #   fill_in_rich_text_area "message[content]", with: "Hello <em>world!</em>"
    def fill_in_rich_text_area(locator = nil, with:)
      find(:rich_text_area, locator)
        .execute_script("this.editor.loadHTML(arguments[0])", with)
    end
  end
end

Capybara.add_selector(:rich_text_area) do
  label("rich text area")
  xpath do |locator|
    if locator.nil?
      XPath.descendant(:"trix-editor")
    else
      input_located_by_name =
        XPath.anywhere(:input).where(XPath.attr(:name) == locator).attr(:id)

      XPath.descendant(:"trix-editor").where(
        XPath.attr(:id).equals(locator) |
        XPath.attr(:placeholder).equals(locator) |
        XPath.attr(:"aria-label").equals(locator) |
        XPath.attr(:input).equals(input_located_by_name),
      )
    end
  end
end
