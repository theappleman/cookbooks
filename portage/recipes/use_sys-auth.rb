template "/etc/portage/package.use/sys-auth" do
    source  "package.use.erb"
    mode    0440
    owner   "root"
    group   "root"
    variables({
        :atoms => node["portage"]["package_use"]["sys-auth"]
    })
end
