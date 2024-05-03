EAPI=8
inherit autotools git-r3

DESCRIPTION="Command Line Interactive and Scriptable Application to access MEGA"
HOMEPAGE="https://mega.nz/cmd"
EGIT_REPO_URI="https://github.com/meganz/MEGAcmd"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"

IUSE="ffmpeg pcre udev ssl sqlite freeimage raw mediainfo"

DEPEND="
		net-misc/curl
		net-dns/c-ares
		dev-libs/crypto++
		sys-libs/zlib
		dev-libs/libuv
		dev-libs/libsodium
		pcre? ( dev-libs/libpcre )
		udev? ( virtual/libudev )
		ssl? ( dev-libs/openssl )
		sqlite? ( dev-db/sqlite:3 )
		freeimage? ( media-libs/freeimage )
		raw? ( media-libs/libraw )
		mediainfo? ( media-libs/libmediainfo )
"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}"/${P}-sdk-codec.patch
)

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	econf \
		$(use_with freeimage) \
		$(use_with ffmpeg) \
		$(use_with sqlite) \
		$(use_with mediainfo libmediainfo) \
		$(use_enable ssl) \
		$(use_with raw libraw) \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die
}

src_test() {
	echo "Tests disabled due to issues with gtest during experimental ebuild installation"
}
