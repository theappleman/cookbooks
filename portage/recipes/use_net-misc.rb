template "/etc/portage/package.use/net-misc" do
    source  "package.use.erb"
    mode    0440
    owner   "root"
    group   "root"
    variables({
        :atoms => node["portage"]["package_use"]["net-misc"]
    })
end
