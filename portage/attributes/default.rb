# ACCEPT_KEYWORDS
#
# example:
# node.default["portage"]["package_keywords"]["my-category"] = {
#       "my-category/some-package" => ["~amd64", "~x86"],
#       "=my-category/another-pkg-1.2.3" => ["~amd64"],
# }
#
# note:
#     .default values are not persistent between chef runs
#     .normal values are persistent (usually set in recipes)
#
# Adding a new category
#     If a cookbook, foo, adds a new category, bar, 
#
#     - Update this file with an empty hash for `bar` that the
#     `foo` attributes/default.rb will append the new flags into.
#     - Create a recipe, recipe/{keywords,use}_bar.rb, to render
#     a template for bar on the node.
#     - Add recipe[portage::{keywords,use}_bar] to the node run_list.
node.default["portage"]["package_keywords"]["dev-libs"] = {}
node.default["portage"]["package_keywords"]["net-misc"] = {}

# USE
#
# example:
# node.default["portage"]["package_use"]["my-category"] = {
#       "my-category/some-package" => ["awesomeness", "-features", "security"],
# }
node.default["portage"]["package_use"]["dev-libs"] = {}
node.default["portage"]["package_use"]["net-misc"] = {}
node.default["portage"]["package_use"]["sys-auth"] = {}

