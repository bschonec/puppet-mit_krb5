# == Define: mit_krb5::custom_section
#
# Add custom/unsupporeted entries to an arbitrary [section] in the
# $krb5_conf_path file.
#
# === Parameters
#
# [*section_name*]
#   The name of the section inside the brackets ('[section]').
#
# [*content*]
#   A hash of the parameters and their values.
#
# === Examples
#
#  mit_krb5::custom_section {'logging':
#    section => {'log_level' => 'debug', 
#                         'owner' => 'root',
#                         'group' => 'root',
#                        }
#
#  Results in:
#  [logging]
#    log_level = debug  
#    owner = root  
#    group = root  
#
# Being appended to the $krb5conf_path file.

define mit_krb5::custom_section(
  $section_name = $title, 
  $content      = {},
) {
  validate_string($section_name)
  validate_hash($content)

  include ::mit_krb5

    concat::fragment { "mit_krb5::custom_section::${title}":
      target  => $mit_krb5::krb5_conf_path,
      order   => "50-custom_section_header-${title}",
      content => template('mit_krb5/custom_section.erb'),
    }
}
