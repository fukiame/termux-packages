TERMUX_PKG_HOMEPAGE=https://ibotpeaches.github.io/Apktool/
TERMUX_PKG_DESCRIPTION="A tool for reverse engineering 3rd party, closed, binary Android apps"
TERMUX_PKG_LICENSE="Apache-2.0"
TERMUX_PKG_MAINTAINER="@termux"
TERMUX_PKG_VERSION=2.12.0
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/iBotPeaches/Apktool/archive/refs/tags/v${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=d87a589778d4369362a99c83a67ca3d365891395aba1be1b85dbf04e72cd3298
TERMUX_PKG_DEPENDS="aapt, aapt2, openjdk-17"
TERMUX_PKG_BUILD_IN_SRC=true

termux_step_make() {
	sh gradlew build shadowJar -x test
}

termux_step_make_install() {
	ls brut.apktool/apktool-cli/build/libs/
	install -Dm600 brut.apktool/apktool-cli/build/libs/apktool-cli.jar \
		$TERMUX_PREFIX/share/java/apktool.jar
	cat <<- EOF > $TERMUX_PREFIX/bin/apktool
	#!${TERMUX_PREFIX}/bin/sh
	exec java -jar $TERMUX_PREFIX/share/java/apktool.jar "\$@"
	EOF
	chmod 700 $TERMUX_PREFIX/bin/apktool
}
