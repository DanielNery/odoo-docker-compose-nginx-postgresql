# Colors
black='\033[0;30m'
gray='\033[0;37m'
yellow='\033[0;33m'
red='\033[0;31m'
blue='\033[0;34m'
reset='\033[0m'
bg1='\033[0;40m'
bg2='\033[0;100m'

progress-bar() {
  local duration=${1}


    already_done() { for ((done=0; done<$elapsed; done++)); do printf "▇"; done }
    remaining() { for ((remain=$elapsed; remain<$duration; remain++)); do printf " "; done }
    percentage() { printf "| %s%%" $(( (($elapsed)*100)/($duration)*100/100 )); }
    clean_line() { printf "\r"; }

  for (( elapsed=1; elapsed<=$duration; elapsed++ )); do
      already_done; remaining; percentage
      sleep 1
      clean_line
  done
  clean_line
}


alternate_color_lines(){
    while read line
    do  
      echo -e "${bg1}$line"
      read line
      echo -e "${bg2}$line"
    done
#    echo -en "${reset}"
}

INFO () {
	echo -e "${blue}$1${reset}"
}

ERROR () {
	echo -e "${red}$1${reset}"
	exit 1
}
