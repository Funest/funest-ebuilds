EAPI=8

DESCRIPTION="Command line tool do drag files into GUI applications."
HOMEPAGE="https://github.com/rkevin-arch/CLIdrag"

SRC_URI="https://github.com/rkevin-arch/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${PN}-${PV}.tar.gz"

LICENSE="WTFPL-2"

SLOT="0"

KEYWORDS="~amd64"

RDEPEND=">=dev-qt/qtbase-6"
BDEPEND="dev-build/make"

src_compile() {
	qmake6 && make || die
}

src_install() {
	# Manually installing -- probably wrong?
	install -Dm 755 bin/drag "${D}/usr/bin/drag"
}
