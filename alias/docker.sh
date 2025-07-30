requirePackage(){
	local requiredPackage="$1"
	command -v "$1" >/dev/null 2>&1
}

echo_green "Loading Docker Aliases"

requirePackage docker && {
	alias d-psa='docker ps -a'
	dockerExecIt (){
		docker exec -it "$1" "$2"
	}
}

docker compose version 2>&1>/dev/null && {

	alias dc-psa='docker compose ps -a'
   alias dc-ud='docker compose up -d'
	alias dc='docker compose '	

	dc-reset_rebuild_allcontainers(){
		echo_red "NON-PERSISTENT DATA WILL BE LOST"
		echo_red "(data overwrite by Dockerfile and entrypoint included)"
		echo_red "RESET ALL CONTAINERS?"
		echo_blue 'will use: docker compose down, rm -f, up --build -d, logs -f'

		sleep 1
		read -p '(YES) to confirm> ' userResponse
		[ "$userResponse" == "YES" ] && {
			docker compose down &&
			docker compose rm -f &&
			docker compose up --build -d &&
			docker compose logs -f
		}
	}
}

unset -f requirePackage
