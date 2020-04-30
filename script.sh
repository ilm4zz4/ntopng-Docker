
usage() {  echo -e " 
Usage: bash $0 [-b -c  -a] 
   -b : create a base image
   -c : build ntopng
   -a : create application image
   "; 
   exit 2 1>&2; exit 1; }

BUILD_BASE_IMAGE="0"
BUILD_NTOPNG="0"
CREATE_APP_NTOPNG="0"

if [ "$#" -lt 1 ]; then
   usage
   exit 1
fi

while getopts ":abc" o; do
    case "${o}" in
        a)
            CREATE_APP_NTOPNG="1"
            ;;
        b)
            BUILD_BASE_IMAGE="1"
            ;;
        c)
	        BUILD_NTOPNG="1"
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
	cd src && docker build -t ilm4zz4/ntopng:build_4.0_dpi_3.0_ssl_1_0_2u -f Dockerfile.build . && cd ..
fi

#Create App
if [ "$CREATE_APP_NTOPNG" == "1" ]
then 
        cd app && docker build -t ilm4zz4/ntopng:4.0_dpi_3.0_ssl_1_0_2u  -f Dockerfile.app .
fi

