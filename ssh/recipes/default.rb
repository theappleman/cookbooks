if node['platform_family'] == "debian" then
	cookbook_file '/etc/ssh/sshd_config' do
		source 'sshd_config'
		notifies    :restart, "service[ssh]"
		mode 0600
	end
	service "ssh"
else
	package "net-misc/openssh" do
	    action      :upgrade
	    notifies    :restart, "service[sshd]"
	end
	cookbook_file '/etc/ssh/sshd_config' do
		source 'sshd_config'
	    	notifies    :restart, "service[sshd]"
		mode 0600
	end
	service "sshd"
end

