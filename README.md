# ActiveFormModel

[![github action status](https://github.com/Hexlet/active_form_model/workflows/main/badge.svg)](https://actions-badge.atrox.dev/hexlet/hexlet-cv/goto)

Painless forms for ActiveRecord. Based on Inheritance. Included:

* Strong parameters
* Validation (based on the model validation)
* Data normalization

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'active_form_model'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install active_form_model

## Usage

1. Create directory *app/forms*
1. Add Form class for a model
1. Add permitted params inside the class
1. Use it as a normal model (without strong_params)

## Generator

Use the supplied generator to generate forms:

    $ rails g active_form_model:form sign_up --model=user

or with namespace model

    $ rails g active_form_model:form admin_post --model=blog/post

### Example

```ruby
# app/forms/user_sign_up_form.rb
class UserSignUpForm < User
  include ActiveFormModel

  # list all the permitted params
  permit :first_name, :email, :password

  # add validation if necessary
  # they will be merged with base class' validation
  validates :password, presence: true

  # optional data normalization
  def email=(email)
    if email.present?
      write_attribute(:email, email.downcase)
    else
      super
    end
  end
end
```

In some cases it is necessary to use ActiveRecord object directly without form. For such cases conveniently to use method `becomes()` (built-in ActiveRecord):

```ruby
user = User.find(params[:id])
form = user.becomes(UserSignUpForm)
```

If you want to build virtual form that is not tied to any class:

```ruby
# frozen_string_literal: true

class SignInForm
  include ActiveFormModel::Virtual

  properties :email, :password

  validates :email, presence: true
  validates :password, presence: true
  validate :user_exists, :user_can_sign_in

  def user_can_sign_in
    errors.add(:password, :cannot_sign_in) if password.present? && !user&.valid_password?(password)
  end

  def user_exists
    errors.add(:email, :user_does_not_exist_html) if email.present? && !user
  end

  def user
    @user ||= User.find_by(email: email)
  end

  def email=(value)
    @email = value.downcase
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/active_form_model. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/active_form_model/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ActiveFormModel project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/active_form_model/blob/master/CODE_OF_CONDUCT.md).
