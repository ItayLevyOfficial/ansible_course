# Run on the control host.
apt install ansible

# Create the ansible user on both the control host and the workstation host.
# The ansible user get created with a home directory (-m) sudo privileges (-G sudo) and bash as the default shell (-s which bash).
# On the google cloud vm the sudo group wasn't exist so i should add ansible enrty via visudo.
sudo useradd -m -s $(which bash) -G sudo ansible
sudo passwd ansible

