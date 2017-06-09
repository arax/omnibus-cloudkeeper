name "cloudkeeper"
## WARN: do not forget to change CLOUDKEEPER_VERSION in the postinst script
default_version "1.4.2"

dependency "ruby"
dependency "rubygems"
dependency "liblzma"
dependency "nginx"

env = {
  "LDFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "CFLAGS" => "-L#{install_dir}/embedded/lib -I#{install_dir}/embedded/include",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}

build do
  gem "install cloudkeeper -n #{install_dir}/bin --no-rdoc --no-ri -v #{version}", :env => env
  delete "#{install_dir}/embedded/docs"
  delete "#{install_dir}/embedded/share/man"
  delete "#{install_dir}/embedded/share/doc"
  delete "#{install_dir}/embedded/ssl/man"
  delete "#{install_dir}/embedded/info"
end
