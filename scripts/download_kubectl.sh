#!/bin/sh

if [[ "${1}" == "" ]]; then
    echo "Please specify K8S_VERSIONS. ex: ./download_kubectl.sh 1.4.6"
    exit 1
fi


uname=$(uname)
if [[ "${uname}" == "Darwin" ]]; then
    platform="darwin"
elif [[ "${uname}" == "Linux" ]]; then
    platform="linux"
else
    echo "Unknown, unsupported platform: (${uname})."
    echo "Supported platforms: Linux, Darwin."
    echo "Bailing out."
    exit 2
fi

machine=$(uname -m)
if [[ "${machine}" == "x86_64" ]]; then
    arch="amd64"
elif [[ "${machine}" == "i686" ]]; then
    arch="386"
elif [[ "${machine}" == "arm*" ]]; then
    arch="arm"
elif [[ "${machine}" == "s390x*" ]]; then
    arch="s390x"
elif [[ "${machine}" == "ppc64le" ]]; then
    arch="ppc64le"
else
    echo "Unknown, unsupported architecture (${machine})."
    echo "Supported architectures x86_64, i686, arm, s390x, ppc64le."
    echo "Bailing out."
    exit 3
fi

url="https://storage.googleapis.com/kubernetes-release/release/v$1/bin/$platform/$arch/kubectl"
echo "$url"

curl -O $url
chmod +x kubectl
mv kubectl /usr/local/bin/

echo "kubectl has been copied to /usr/local/bin/. Try 'kubectl version' and config your cluster"
