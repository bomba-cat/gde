clear

Start(){
	clear
	echo --Start--

	read -p "Enter the secret Password: " pass
	echo Setting up password.txt...
	echo $pass > password.txt
	echo Done!

	echo Trying to start Containers, Networks and Volumes...
	docker-compose up -d
	echo Done!

	echo Waiting for Gitlab...
	docker wait gitlab
	echo Fetching root Password...
	docker exec -it gitlab grep 'Password: ' /etc/gitlab/initial_root_password
	echo Done!
}

Stop(){
	clear
	echo Stopping and Deleting all Containers and Networks...
	docker-compose down
	echo Done!
}

Delete(){
	clear
	echo WARNING!
	echo This will DELETE any persistent DATA and theres no coming back!
	
	read -p "Continue? [y/n]" proceed
	if [[ $proceed == "y" ]] then
		echo Stopping and Deleting all Containers, Networks and Volumes...
		docker-compose down -v
		echo Done!
	fi
}

echo Welcome to GDE Operator!
echo
echo What Operation do you want to do?
echo
echo [1] Start
echo [2] Stop
echo [3] Delete
read -p "_: " op

if [[ $op == "1" ]] then
	Start
fi
if [[ $op == "2" ]] then
	Stop
fi
if [[ $op == "3" ]] then
	Delete
fi
