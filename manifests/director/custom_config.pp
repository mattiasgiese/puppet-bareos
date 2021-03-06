# == Define: bareos::director::custom_config
#
# Include a custom configuration file in <tt>/etc/bareos/bareos-dir.d</tt>.
#
# === Parameters
#
# [*ensure*]
#   Ensure the file is present or absent.  The only valid values are <tt>file</tt> or
#   <tt>absent</tt>. Defaults to <tt>file</tt>.
# [*director_server*]
#   WHere this config will be deployed, if using stored configs.
# [*content*]
#   String containing the content for the configuration file.  Usually supplied
#   with a template.
# [*source*]
#   The source location of the configuration file to deploy in <tt>bareos-dir.d</tt>.
#
# === Examples
#
# Provide some examples on how to use this type:
#
#   bareos::director::custom_config { 'namevar' :
#     ensure => file,
#     source => 'puppet:///modules/my_bareos/custom.conf'
#   }
#
define bareos::director::custom_config (
  $ensure   = 'file',
  $director_server = undef,
  $content  = undef,
  $source   = undef
) {
  if !($ensure in ['file', 'absent']) {
    fail('The only valid values for the ensure parameter are file or absent')
  }

  if $content and $source {
    fail('You may not supply both content and source parameters')
  } elsif $content == undef and $source == undef {
    fail('You must supply either the content or source parameter')
  }

  file { "/etc/bareos/bareos-dir.d/custom-${name}.conf":
    ensure  => file,
    owner   => 'bareos',
    group   => 'bareos',
    mode    => '0640',
    content => $content,
    source  => $source,
    require => File['/etc/bareos/bareos-dir.conf'],
    before  => Service['bareos-dir'],
    notify  => Exec['bareos-dir reload'],
  }
}
