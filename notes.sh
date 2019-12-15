# -f1: the first paragraph. -d ' ': use space as delimiter instead of tab.
CHECKSUM=$(curl http://software.xyzcorp.com/enigma-checksum.txt | cut -f1 -d ' ')
# checksum: protocol:[checksum|checksum_url] to verify that the file has the right checksum.
ansible qa-servers -m get_url -a "url=http://software.xyzcorp.com/enigma.tgz dest=/tmp/enigma.tgz checksum=sha256:$CHECKSUM"
# unarchive can handle almost every compression, bat there must be an archive (i.e. not regular file)
ansible qa-servers -b -m unarchive -a "src=/tmp/enigma.tgz dest=/opt/ remote_src=yes"
# regexp is exactly the line I want to subsitute.
ansible qa-servers -b -m lineinfile -a "regexp=DEPLOY_CODE line=CODE_RED path=/opt/enigma/details.txt"
# recurse=yes to go over all the files in that directory.
ansible qa-servers -b -m file -a "recurse=yes state=directory path=/opt/enigma/secret group=protected"
ansible all -b -m file -a "state=absent path=/opt/enigma/tmp/deployment-passwords.txt"
