
usage() {  echo -e " 
Usage: bash $0 [-b <string> -c <string> -a <string> ] 
   -b : create a base image
   -c : build ntopng
   -a : create application image
   
   "; 
   exit 2 1>&2; exit 1; }

while getopts ":b:c:a" o; do
    case "${o}" in
        b)
	    cd base && docker build -t ilm4zz4/ntopng:base -f Dockerfile.base . && cd ..
            ;;
        c)
            cd src && docker build -t ilm4zz4/ntopng:build -f Dockerfile.build . && cd ..
            ;;
        a)
            cd app && docker build -t ilm4zz4/ntopng -f Dockerfile.app .
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))




