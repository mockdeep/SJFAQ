# frozen_string_literal: true

module Views
  module Layouts
    class Application < Components::Base
      include Phlex::Rails::Helpers::CSRFMetaTags
      include Phlex::Rails::Helpers::CSPMetaTag
      include Phlex::Rails::Helpers::StylesheetLinkTag
      include Phlex::Rails::Helpers::JavascriptIncludeTag
      include Phlex::Rails::Helpers::LinkTo
      include Phlex::Rails::Helpers::CurrentPage
      include Phlex::Rails::Helpers::Flash

      def view_template
        doctype

        html do
          head do
            title { "Justice.Garden" }
            csrf_meta_tags
            csp_meta_tag

            stylesheet_link_tag(
              "application",
              media: "all",
              "data-turbo-track": "reload",
            )
            javascript_include_tag(
              "application",
              "data-turbo-track": "reload",
              defer: true,
            )
          end

          body do
            if current_user.logged_in?
              plain(current_user.email)
              br
              link_to("Account", account_path(current_user))
              link_to("Log Out", session_path, method: :delete)
            else
              unless current_page?(new_session_path)
                link_to("Log In", new_session_path)
              end
              link_to("Sign Up", new_account_path)
            end

            div(class: "flashes") do
              flash.each do |type, message|
                div(class: "flash-#{type}") { message }
              end
            end

            yield
          end
        end
      end
    end
  end
end
