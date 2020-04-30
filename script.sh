
usage() {  echo -e " 
Usage: bash $0 [-b <string> -c <string> -a <string> ] 
   -b : create a base image
   -c : build ntopng
   -a : create application image
   -t : tag 
   
   "; 
   exit 2 1>&2; exit 1; }

BUILD_BASE_IMAGE="0"
BUILD_NTOPNG=0
CREATE_APP_NTOPNG="0"

if [ "$#" -ne 1 ]; then
   usage
   exit 1
fi

while getopts ":b:c:a:t:r" o; do
    case "${o}" in
        b)
            BUILD_BASE_IMAGE="1"
            ;;
        c)
	    BUILD_NTOPNG="1"
            ;;
        a)
            CREATE_APP_NTOPNG="1"
            ;;

        t)
            TAG=${OPTARG}
            ;;
        r)
            iRTAG=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))


# BUild base image
if [ "$BUILD_BASE_IMAGE" == "1" ]
then 
	cd base && docker build -t ilm4zz4/ntopng:base -f Dockerfile.base . && cd ..
fi

# Buid ntopng

if [ "$BUILD_NTOPNG" == "1" ]
then 
	cd src && docker build -t ilm4zz4/ntopng:build -f Dockerfile.build . && cd ..
fi

#Create App
if [ "$CREATE_APP_NTOPNG" == "1" ]
then 
        cd app && docker build -t ilm4zz4/ntopng -f Dockerfile.app .
fi

#retag
if [ "$CREATE_APP_NTOPNG" == "1" ]
then
echo ""
fi
