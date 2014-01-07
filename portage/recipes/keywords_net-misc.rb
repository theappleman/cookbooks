template "/etc/portage/package.keywords/net-misc" do
    source  "package.keywords.erb"
    mode    0440
    owner   "root"
    group   "root"
    variables({
        :atoms => node["portage"]["package_keywords"]["net-misc"]
    })
end
