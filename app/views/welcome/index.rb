# frozen_string_literal: true

module Views
  module Welcome
    class Index < Views::Base
      include Phlex::Rails::Helpers::LinkTo

      attr_accessor :questions

      def initialize(questions:)
        super()
        self.questions = questions
      end

      def view_template
        article do
          link_to(t("add_question"), new_question_path) if current_user.admin?
          questions.each { |question| render_question(question) }
        end
      end

      private

      def render_question(question)
        h3 { question.text }
        if current_user.admin?
          link_to(t("edit_question"), edit_question_path(question))
        end

        if question.answer
          p { question.answer.text.to_s }
          if current_user.admin?
            link_to(t("edit_answer"), edit_answer_path(question.answer))
          end
        elsif current_user.admin?
          link_to(t("add_answer"), new_question_answer_path(question))
        end
      end
    end
  end
end
