node[:deploy].each do |application, deploy|
	if deploy[:application_type] != 'php'
		Chef::Log.debug("Skipping cakephp::permissions application #{application} as it is not an PHP app")
		next
	end

	execute 'tmp-directory-permission' do
		action :run
		user 'root'
		command "chmod 777 -R #{deploy[:deploy_to]}/current/app/tmp"
	end
	
end