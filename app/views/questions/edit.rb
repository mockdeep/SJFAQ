# frozen_string_literal: true

module Views
  module Questions
    class Edit < Views::Base
      attr_accessor :question

      def initialize(question:)
        super()
        self.question = question
      end

      def view_template
        form_with(model: question) do |form|
          form.label(:text)
          form.text_field(:text)
          form.submit(t("update_question"))
        end
      end
    end
  end
end
