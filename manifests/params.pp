# == Class ocsinventory::params
#
class ocsinventory::params {
  $agent             = true
  $agent_ocs_mode    = 'cron'
  $agent_ocs_pause   = 100
  $agent_ocs_server  = undef
  $agent_ocs_tag     = undef
  $pkg_agent_ensure  = present
  $pkg_server_ensure = present
  $server            = false
  $db_host           = 'localhost'
  $db_port           = 3306
  $db_name           = 'ocsweb'
  $db_local          = 'ocsweb'
  $db_user           = 'ocs'
  $db_passs          = 'ocs'

  case $::osfamily {
    'RedHat': {
      $config_dir         = '/etc/ocsinventory'
      $config_dir_mode    = '0755'
      $config_dir_recurse = false
      $config_file_mode   = '0644'
      $config_group       = 'root'
      $config_user        = 'root'
      $log_dir_agent      = '/var/log/ocsinventory-agent'
      $log_dir_server     = '/var/log/ocsinventory-server'
      $pkg_deps           = undef
      case $::lsbmajdistrelease {
        '7': {
          $pkg_list_agent = [
            'ocsinventory-agent',
            'ocsinventory-ipdiscover',
          ]
        }

        '6': {
          $pkg_list_agent = [
            'ocsinventory-agent',
          ]
        }
        default : {
          $pkg_list_agent = [
            'ocsinventory-agent',
            'ocsinventory-ipdiscover',
          ]
        }
      }

      $pkg_list_server = [
        'ocsinventory',
        'ocsinventory-reports',
        'ocsinventory-server',
      ]
    }
    'Debian': {
      $config_dir         = '/etc/ocsinventory'
      $config_dir_mode    = '0755'
      $config_dir_recurse = false
      $config_file_mode   = '0644'
      $config_group       = 'root'
      $config_user        = 'root'
      $log_dir_agent      = '/var/log/ocsinventory-agent'
      $log_dir_server     = '/var/log/ocsinventory-server'
      $pkg_deps           = undef
      $httpd_user         = 'www-data'
      $httpd_group        = 'www-data'

      $pkg_list_agent = [
            'ocsinventory-agent',
      ]
      $pkg_list_server = [
        'ocsinventory-reports',
        'ocsinventory-server',
      ]
      $deploy_reports_dir         = '/usr/share/ocsinventory-reports'
    }
    default: {
      fail "Operating system ${::operatingsystem} is not supported."
    }
  }
}

