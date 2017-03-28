name "qemu-img"
default_version "2.8.0"

version "2.8.0" do
  source md5: "38f88993e766ebc2b5983310e74dc681"
end

dependency "glib2"

source :url => "http://download.qemu-project.org/qemu-#{version}.tar.xz"

relative_path "qemu-#{version}"

env = {
  "PKG_CONFIG_PATH" => "#{install_dir}/embedded/lib/pkgconfig",
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib64 -I#{install_dir}/embedded/include",
  "CPPFLAGS" => "-L#{install_dir}/embedded/lib -L#{install_dir}/embedded/lib64 -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib"
}

build do
  configure = [
    "./configure",
    "--prefix=#{install_dir}/embedded"
  ]

  command configure.join(" "), :env => env
  command "make -j #{workers} qemu-img", :env => env
  copy "qemu-img", "#{install_dir}/embedded/sbin/"
end
