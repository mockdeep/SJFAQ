# frozen_string_literal: true

module Views
  module Questions
    class New < Views::Base
      def view_template
        form_with(scope: :question, url: questions_path) do |form|
          form.label(:text)
          form.text_field(:text)
          form.submit(t("create_question"))
        end
      end
    end
  end
end
