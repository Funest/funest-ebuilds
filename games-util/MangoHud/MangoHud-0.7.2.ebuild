EAPI=8

DESCRIPTION="A Vulkan and OpenGL overlay for monitoring CPU/GPU performance in games."
HOMEPAGE="https://github.com/flightlessmango/MangoHud"

inherit meson xdg-utils

SRC_URI="https://github.com/flightlessmango/MangoHud/releases/download/v${PV}/MangoHud-v${PV}-Source.tar.xz"

S="${WORKDIR}/MangoHud-v${PV}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

IUSE="+X wayland dbus"
REQUIRED_USE="|| ( X wayland )"

RDEPEND="dev-util/vulkan-headers
		dev-util/glslang
		media-libs/libglvnd
		dev-python/mako
		X? ( x11-libs/libX11 )
		wayland? ( dev-libs/wayland )
		dbus? ( sys-apps/dbus )"

BDEPEND="dev-build/meson
		dev-build/ninja"

src_configure() {
	local emesonargs=(
		-Dwith_xnvctrl=disabled
		$(meson_feature wayland with_wayland)
		$(meson_feature dbus with_dbus)
	)
	meson_src_configure
}

src_install() {
	meson_install

	# Move weird doc location
	mv "${D}/usr/share/doc/mangohud" "${D}/usr/share/mangohud"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
