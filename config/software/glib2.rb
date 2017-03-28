name "glib2"
default_version "2.50.3"

version "2.50.3" do
  source md5: "410d41db542fdcd600ca90cf5100ab6f"
end

dependency "gettext"
dependency "libffi"
dependency "pcre"

source :url => "http://fossies.org/linux/misc/glib-#{version}.tar.gz"

relative_path "glib-#{version}"

env = {
  "PKG_CONFIG_PATH" => "#{install_dir}/embedded/lib/pkgconfig",
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib64 -I#{install_dir}/embedded/include",
  "CPPFLAGS" => "-L#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib64 -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
  "PATH" => "#{install_dir}/embedded/bin:" + ENV['PATH'],
}

build do
  configure = [
    "./configure",
    "--prefix=#{install_dir}/embedded",
    "--disable-selinux",
	"--with-pcre=system",
	"--with-libiconv",
  ]

  command configure.join(" "), :env => env
  command "make -j #{workers}", :env => env
  command "make install"
end
