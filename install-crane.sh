#!/bin/bash
# Installs crane - https://github.com/michaelsauter/crane
# Supports Ubuntu, Debian
set -o errexit
set -o nounset

# Parameters that can be overriden. Mainly just useful defaults.
: ${CRANE_VERSION:="0.12.0"}
: ${PLATFORM:="linux"}
: ${CRANE_ARCH:="amd64"}

# These probably shouldn't be changed
: ${CRANE_BIN:="crane"}
: ${CRANE_DIR:="/usr/local/bin"}

# Checkinstall specific prameters
: ${CRANE_PKG_MAINTAINER:="thomas@scalr.com"}
: ${CRANE_PKG_DEPS:='lxc-docker \( \>= 1.0.0\)'}
: ${CRANE_PKG_LICENSE:='MIT'}


# Actually install now
export DEBIAN_FRONTEND=noninteractive
mkdir -p "${CRANE_DIR}"

# Ensure we have curl and checkinstall
apt-get install -y -q curl
apt-get install -y -q --no-install-recommends checkinstall # Checkinstall pulls a ton of build stuff we don't want.

# Move to a working directory
work_dir=$(mktemp -d)
cd "${work_dir}"
trap "rm -rf -- ${work_dir}" EXIT

# Create Checkinstall files
echo "Crane - Lift containers with ease" > description-pak

# Actually install
CRANE_REPO="https://github.com/michaelsauter/crane"
curl -L -o "${CRANE_BIN}" "${CRANE_REPO}/releases/download/v${CRANE_VERSION}/crane_${PLATFORM}_${CRANE_ARCH}"
chmod +x -- "${CRANE_BIN}"
checkinstall \
  --type=debian \
  --install=yes \
  --pkgname="${CRANE_BIN}" \
  --pkgsource="${CRANE_REPO}" \
  --pkgversion="${CRANE_VERSION}" \
  --pkgarch="${CRANE_ARCH}" \
  --pkglicense="${CRANE_PKG_LICENSE}" \
  --requires="${CRANE_PKG_DEPS}" \
  --maintainer="${CRANE_PKG_MAINTAINER}" \
  --nodoc \
  --default \
  mv "${CRANE_BIN}" "${CRANE_DIR}"
