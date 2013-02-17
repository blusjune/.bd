#!/bin/sh

## bsc.github.setup_all.sh
##
## Sun May  6 21:27:49 KST 2012


_this_prog="$(basename $0)";
_timestamp="$(date +%Y%m%d_%H%M%S)";




## variables to be set from user input
_git_username_default="blusjune";
_git_email_default="blusjune+github01@gmail.com";


if [ "X$_git_username" = "X" ]; then
        read -p ">>> _git_username ? " _ans;
        if [ "X$_ans" = "X" ]; then
                _git_username=$_git_username_default;
        else
                _git_username=$_ans;
        fi
fi
if [ "X$_git_email" = "X" ]; then
        read -p ">>> _git_email ? " _ans;
        if [ "X$_ans" = "X" ]; then
                _git_email=$_git_email_default;
        else
                _git_email=$_ans;
        fi
fi




github_ssh_keygen()
{
_rsakey="id_rsa_github_$_git_username";
_rsakey_pub="${_rsakey}.pub";
_sshpath="${HOME}/.ssh";
_backup_d="key_backup.$_timestamp";

if [ ! -d $_sshpath ]; then
	echo "
>>> your ~/.ssh directory does not exist, so create now";
	echo "# openssh-server and openssh-client should be installed prior to this action";
	ssh localhost;
fi

(
cd $_sshpath;
mkdir $_backup_d;
if [ -f $_rsakey ]; then
	mv $_rsakey $_backup_d;
fi
if [ -f $_rsakey_pub ]; then
	mv $_rsakey_pub $_backup_d;
fi
)

#ssh-keygen -t rsa -C "blusjune+github01@gmail.com" -f $_sshpath/$_rsakey;
ssh-keygen -t rsa -C "$_git_email" -f $_sshpath/$_rsakey;

echo "
>>> Good! Your ssh pubkey generated:";
echo "-----";
cat $_sshpath/$_rsakey_pub;
echo "-----";
echo ">>> A. work to do at github.com";
echo "1. Please log into 'https://github.com/${_git_username}'";
echo "2. On the GitHub site:";
echo "   click 'Account Settings' > click 'SSH keys' > click 'Add SSH key'";
echo "3. Open the ~/.ssh/$_rsakey_pub file, copy the contents";
echo "4. Paste it into the 'Key' field on the web browser";
echo "";
echo ">>> B. work to do here";
echo "1. Currently there is no symbolic link to your";
echo "   ${_rsakey} and ${_rsakey_pub} at ~/.ssh directory'";
echo "   So please create symbolic links to your github rsa keys";
echo "   (e.g., $ ln -s ${_rsakey} id_rsa; ln -s ${_rsakey_pub} id_rsa_pub;)";
echo "-----";

echo "";
read -p "Do you want to escape to shell to create symbolic links to your RSA keys? [y|n] " _ans;
if [ "X$_ans" = "Xy" -o "X$_ans" = "XY" ]; then
	(PS1='\W \$ ' bash;)
fi

echo "";
read -p "Ok, now, are you ready to test your GitHub configuration? [y|n] " _ans;
if [ "X$_ans" = "Xy" -o "X$_ans" = "XY" ]; then
	echo ">>> ssh T git@github.com -i $_sshpath/$_rsakey";
	ssh -T git@github.com -i $_sshpath/$_rsakey;
	echo "";
	echo ">>> Your ssh key registration to GitHub is successful";
	echo "    if you could see the following message:";
	echo "Hi ${_git_username}! You've successfully authenticated, but GitHub does not provide shell access.";
fi
}




github_user_setup()
{
echo ">>> git config: 1. setting user name and email";
git config --global user.name "Brian Myungjune JUNG";
git config --global user.email "$_git_email";
#git config --global user.name "Brian Myungjune JUNG";
#git config --global user.email "brian.m.jung+github@gmail.com";

echo ">>> git config: 2. setting GitHub account";
git config --global github.user $_git_username
#git config --global github.user blusjune
#git config --global github.token $_github_api_token;   # no need to do this any more (github changed this stuff)
}




case $_this_prog in
        "bsc.github.setup_all") ##
                github_ssh_keygen;
                github_user_setup;
                ;;
        "bsc.github.ssh_keygen") ##
                github_ssh_keygen;
                ;;
        "bsc.github.user_setup") ##
                github_user_setup;
                ;;
        *) ##
                echo ">>> ERROR: we does not support '$_this_prog' program";
                exit 1;
                ;;
esac




