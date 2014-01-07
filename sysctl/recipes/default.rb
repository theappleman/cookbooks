cookbook_file '/etc/sysctl.d/file-max.conf' do
	source 'file-max.conf'
	mode 0644
end

cookbook_file '/etc/sysctl.d/grsec-symlinks.conf' do
	source 'grsec-symlinks.conf'
	mode 0644
end

cookbook_file '/etc/sysctl.d/ipv6-tmp.conf' do
	source 'ipv6-tmp.conf'
	mode 0644
end

cookbook_file '/etc/sysctl.d/overcommit.conf' do
	source 'overcommit.conf'
	mode 0644
end

