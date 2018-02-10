name "base"
description "Base role applied to all nodes."

run_list(
  "recipe[apt]",
  "recipe[git]",
  "recipe[build-essential]",
  "recipe[sudo]",
  "recipe[users::sysadmins]",
  "recipe[vim]"
)

override_attributes(
  :authorization => {
    :sudo => {
      :users => ["ubuntu", "vagrant"],
      :passwordless => true
    }
  }
)
