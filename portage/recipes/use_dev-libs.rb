template "/etc/portage/package.use/dev-libs" do
    source  "package.use.erb"
    mode    0440
    owner   "root"
    group   "root"
    variables({
        :atoms => node["portage"]["package_use"]["dev-libs"]
    })
end
