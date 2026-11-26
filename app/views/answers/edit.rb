# frozen_string_literal: true

module Views
  module Answers
    class Edit < Views::Base
      attr_accessor :answer

      def initialize(answer:)
        super()
        self.answer = answer
      end

      def view_template
        h3 { answer.question.text }

        form_with(model: answer) do |form|
          form.label(:text)
          form.rich_text_area(:text)
          form.submit(t("update_answer"))
        end
      end
    end
  end
end
