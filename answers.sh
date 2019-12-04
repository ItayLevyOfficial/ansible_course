# Run on the control host.
apt install ansible

# Create the ansible user on both the control host and the workstation host.
# The ansible user get created with a home directory (-m) sudo privileges (-G sudo) and bash as the default shell (-s which bash).
# On the google cloud vm the sudo group wasn't exist so i should add ansible enrty via visudo.
# ansible  ALL=(ALL) NOPASSWD: ALL
sudo useradd -m -s $(which bash) -G sudo ansible
sudo passwd ansible

# Copy the ~/.ssh/id_rsa.pub content from the control host and to append it to the end of the ~/.ssh/authorized_keys file in the client host

# To be able to run the yum module on the remote host, you should set a default python interpeter. I did this by typing: sudo ln -fs /usr/bin/python3 /usr/bin/python
