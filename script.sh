
usage() {  echo -e " 
Usage: bash $0 [-b -c  -a] 
   -b : create a base image
   -o : build openssl
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

while getopts ":abco" o; do
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
        o)
	        OPEN_SSL="1"
            ;;      
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))


openssl_version=OpenSSL_1_0_2u
ndpi_version=3.0
ntopng_version=4.0

# BUild base image
if [ "$BUILD_BASE_IMAGE" == "1" ]
then 
	cd base && docker build \
    -t ilm4zz4/ntopng:base \
    -f Dockerfile.base . && cd ..
fi

#Build openssl
if [ "$OPEN_SSL" == "1" ]
then 
	cd src && docker build \
    -t ilm4zz4/ntopng:base_${openssl_version} \
    --build-arg openssl=${openssl_version} \
    -f Dockerfile.openssl . && cd ..
fi

# Buid ntopng
if [ "$BUILD_NTOPNG" == "1" ]
then 
	cd src && docker build \
    -t ilm4zz4/ntopng:build_ntopng_${ntopng_version}_ndpi_${ndpi_version}_${openssl_version} \
    --build-arg ndpi_version=${ndpi_version} \
    --build-arg ntopng_version=${ntopng_version} \
    --build-arg base_openssl_version=base_${openssl_version} \
    -f Dockerfile.ntopng . && cd ..
fi

#Create App
if [ "$CREATE_APP_NTOPNG" == "1" ]
then 
        cd app && docker build \
        -t ilm4zz4/ntopng:ntopng_${ntopng_version}_ndpi_${ndpi_version}_${openssl_version}  \
        --build-arg built_image=build_ntopng_${ntopng_version}_ndpi_${ndpi_version}_${openssl_version} \
        -f Dockerfile.app . && cd .. 
fi

