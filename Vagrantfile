Vagrant.configure("2") do |config|
  config.vm.box = "exoscale-centos-6.5"
  config.ssh.username = "root"
  config.ssh.pty = true
  config.vm.provider :cloudstack do |cloudstack, override|
    cloudstack.api_key = "AAAA"
    cloudstack.secret_key = "AAAA"

    cloudstack.service_offering_id = "b6e9d1e8-89fc-4db3-aaa4-9b4c5b1d0844"

    cloudstack.security_group_ids = [ "a3267912-b410-4b2c-96ff-eeb51e793c39" ]
    cloudstack.keypair = "vagrant"
  end

  config.omnibus.chef_version = "11.16.0"
  config.berkshelf.berksfile_path = './Berksfile'
  config.berkshelf.enabled = true

  config.vm.provision "shell", inline: "setenforce 0"
  
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ['cookbooks']

    chef.run_list = [
      'recipe[hostname::default]',
      'recipe[cloudstack_wrapper::all_in_one]'
    ]

    chef.json = {
      'set_fqdn' => '*.localdomain'
    }
  end

end

