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

# The following src_install function is implemented as default by portage, so
# you only need to call it, if you need different behaviour.
#src_install() {
	# You must *personally verify* that this trick doesn't install
	# anything outside of DESTDIR; do this by reading and
	# understanding the install part of the Makefiles.
	# This is the preferred way to install.
	#emake DESTDIR="${D}" install

	# When you hit a failure with emake, do not just use make. It is
	# better to fix the Makefiles to allow proper parallelization.
	# If you fail with that, use "emake -j1", it's still better than make.

	# For Makefiles that don't make proper use of DESTDIR, setting
	# prefix is often an alternative.  However if you do this, then
	# you also need to specify mandir and infodir, since they were
	# passed to ./configure as absolute paths (overriding the prefix
	# setting).
	#emake \
	#	prefix="${D}"/usr \
	#	mandir="${D}"/usr/share/man \
	#	infodir="${D}"/usr/share/info \
	#	libdir="${D}"/usr/$(get_libdir) \
	#	install
	# Again, verify the Makefiles!  We don't want anything falling
	# outside of ${D}.
#}
