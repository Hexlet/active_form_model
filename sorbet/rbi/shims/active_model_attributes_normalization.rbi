# typed: true

# Rails' ActiveModel::Attributes::Normalization adds the `normalizes` class method,
# but it isn't present in Sorbet's upstream RBIs for some versions/configs.
module ActiveModel::Attributes::Normalization
  extend T::Helpers

  module ClassMethods
    extend T::Sig

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
