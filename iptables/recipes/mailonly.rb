if node['platform_family'] == 'debian' then
	package 'iptables-persistent'
	template '/etc/iptables/rules.v4' do
		source 'iptables.erb'
		mode 0644
		variables({
			:tcp => [ 25, 143, 465, 587, 993],
			:udp => [],
		})
		notifies    :restart, "service[iptables-persistent]"
	end
	template '/etc/iptables/rules.v6' do
		source 'ip6tables.erb'
		mode 0644
		variables({
			:tcp => [ 25, 143, 465, 587, 993],
			:icmp=> [ 128, 133, 134, 135, 136, 137 ],
			:udp => [],
		})
		notifies    :restart, "service[iptables-persistent]"
	end
	service 'iptables-persistent'
else
	package 'iptables'
	template '/var/lib/iptables/rules-save' do
		source 'iptables.erb'
		mode 0644
		variables({
			:tcp => [ 25, 143, 465, 587, 993],
			:udp => [],
		})
		notifies    :restart, "service[iptables]"
	end
	template '/var/lib/ip6tables/rules-save' do
		source 'ip6tables.erb'
		mode 0644
		variables({
			:tcp => [ 25, 143, 465, 587, 993],
			:icmp=> [ 128, 133, 134, 135, 136, 137 ],
			:udp => [],
		})
		notifies    :restart, "service[ip6tables]"
	end
	service 'iptables' do
		action [:enable, :start]
	end
	service 'ip6tables' do
		action [:enable, :start]
	end
end
