# typed: true

# Sorbet does not always follow transitive mixins coming from ActiveSupport::Concern,
# so we declare the class-level DSL that `ActiveFormModel::Virtual` provides (or
# pulls in) for consumers.
module ActiveFormModel::Virtual
  extend T::Helpers

  module ClassMethods
    extend T::Sig

    sig { params(attrs: T.untyped).void }
    def fields(*attrs); end

    sig do
      params(
        attributes: T.untyped,
        with: T.untyped,
        apply_to_nil: T::Boolean,
        blk: T.nilable(T.proc.params(value: T.untyped).returns(T.untyped))
      ).void
    end
    def normalizes(*attributes, with: nil, apply_to_nil: false, &blk); end
  end

  mixes_in_class_methods(ClassMethods)
end
