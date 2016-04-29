USER_SCRIPT="user-script.sh"
{ [[ -f common.sh ]] && echo "Running ${USER_SCRIPT}" && bash ${USER_SCRIPT} } || echo "${USER_SCRIPT} not found, continuing."
apt-get update
apt-get --yes remove openjdk-6-jre-headless
apt-get --yes install openjdk-7-jdk
