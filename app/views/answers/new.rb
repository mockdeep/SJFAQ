# frozen_string_literal: true

module Views
  module Answers
    class New < Views::Base
      attr_accessor :question

      def initialize(question:)
        super()
        self.question = question
      end

      def view_template
        h3 { question.text }

        url = question_answers_path(question)
        form_with(scope: :answer, url:) do |form|
          form.label(:text)
          form.rich_text_area(:text)
          form.submit(t("create_answer"))
        end
      end
    end
  end
end
