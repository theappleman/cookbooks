include_attribute "portage"

node.default["portage"]["package_use"]["dev-libs"]["dev-libs/openssl"] = ["-bindist", "kerberos"]
