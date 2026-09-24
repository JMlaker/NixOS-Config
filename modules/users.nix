{ ... }:
{
	# Define user 'josh'
	users.users.josh = {
		isNormalUser = true;
		extraGroups = [ "wheel" "networkmanager" ];
		openssh.authorizedKeys.keys = [
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN8DPJ4quEHosfE5uO2FHsFU7XpruwMn3QWt3MElFbSp jmlaker04@gmail.com"
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILAR6VkoJrclq6SkofYSucU70cpU255dHpvpoarVxxvH Shortcuts on Josh’s iPhone"
			"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJaGUqT8tYnAecxgizga6fVF3e0LLIH1y0LKrwP1lw+A jmlaker04@gmail.com"
			"sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIPiie4AgURN/UDRCCbCymaWquTDqdFQ1yuevt7vNd+MYAAAABHNzaDo= Yubikey 5C Whole"
			"sk-ssh-ed25519@openssh.com AAAAGnNrLXNzaC1lZDI1NTE5QG9wZW5zc2guY29tAAAAIPCr6Uvk8q2ZtQqWlirR05uPNXww2Hi1hS66mz2+JBq0AAAABHNzaDo= Yubikey 5C Mini"
	
		];
	};
}
