# Ad-hoc command mission
# Create the users
ansible -i hosts dbsystems -m user -b -a 'name=consultant'
ansible -i hosts dbsystems -m user -b -a 'name=supervisor'

# Make sure the .ssh directory exists.
ansible -i hosts dbsystems -b -m 'file' -a 'owner=supervisor group=supervisor path="/home/supervisor/.ssh" state="directory" mode="700"'
ansible -i hosts dbsystems -b -m 'file' -a 'owner=consultant group=consultant path="/home/consultant/.ssh" state="directory" mode="700"'

# Copy the 'authorized_keys file to the nodes'
ansible -i hosts dbsystems -b -m 'copy' -a 'src="authorized_keys" dest="/home/consultant/.ssh/" mode="600" owner="consultant" group="consultant"'
ansible -i hosts dbsystems -b -m 'copy' -a 'src="authorized_keys" dest="/home/supervisor/.ssh/" mode="600" owner="supervisor" group="supervisor"'

# Enable and start the auditd service
ansible all -i hosts -m service -b -a 'state="started" enabled="yes" name=auditd'
