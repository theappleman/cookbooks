include_attribute "portage"

node.default["portage"]["package_use"]["net-misc"]["net-misc/openssh"] = ["-bindist", "kerberos"]
