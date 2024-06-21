# frozen_string_literal: true

Rails.autoloaders.main.push_dir(
  "#{Rails.root}/app/lib",
  namespace: Rails.application.class.module_parent
)
