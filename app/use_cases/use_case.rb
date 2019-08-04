# frozen_string_literal: true

# UseCase module
module UseCase
  extend ActiveSupport::Concern
  include ActiveModel::Validations

  # ClassMethods
  module ClassMethods
    def perform(*args)
      new(*args).tap(&:perform)
    end
  end

  def perform
    raise NotImplementedError
  end

  def success?
    errors.none?
  end
end
