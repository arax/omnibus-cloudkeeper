name 'cloudkeeper'
maintainer 'Boris Parak <parak@cesnet.cz>'
homepage 'https://github.com/the-cloudkeeper-project/cloudkeeper'
description 'Synchronize cloud appliances between AppDB and cloud platforms.'

install_dir     '/opt/cloudkeeper'
build_version   "1.6.0"
build_iteration 1

override :rubygems, :version => '2.6.8'
## WARN: do not forget to change RUBY_VERSION in the postinst script
##       when switching to a new minor version
override :ruby, :version => '2.2.8'

# creates required build directories
dependency 'preparation'

# cloudkeeper dependencies/components
dependency 'cloudkeeper'

# version manifest file
dependency 'version-manifest'

if File.exists? '/etc/redhat-release'
  runtime_dependency 'qemu-img >= 2.0'
else
  runtime_dependency 'qemu-utils (>= 2.0)'
end

# tweaking package-specific options
package :deb do
  vendor 'CESNET, Grid Department <cloud@metacentrum.cz>'
  license 'Apache License, Version 2.0'
  priority 'extra'
  section 'net'
end

package :rpm do
  vendor 'CESNET, Grid Department <cloud@metacentrum.cz>'
  license 'Apache License, Version 2.0'
  category 'Applications/System'
end

exclude '\.git*'
exclude 'bundler\/git'
