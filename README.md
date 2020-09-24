# deluge-cookbook

Helps manage [Deluge](http://deluge-torrent.org/), the BitTorrent client

## Resources

### `deluge_auth`
Defines an auth file (users/passwords) for deluge

* `local_password`: Password for local user
* `users`: Dictionary of `username => password`
* `auth_file`: Location of file. Defaults to resource name

### `deluge_settings`
Collection of settings in a dictionary. Uses a custom Python script that rides on the Deluge framework.

* `settings`: Dictionary of `name => value`
* `deluge_config`: Config directory.

### `deluge_systemd_file`
SystemD service file generator for a Deluge service.

* `user`: User for the process
* `group`: Group for the process
* `mask`: [File mask (umask)](https://en.wikipedia.org/wiki/Umask) for the process
* `config_dir`: Config directory for deluge
* `log_location`: Filename for the service's log
* `log_level`: Level of verbosity for the Deluge service. See `-L` in `deluged --help`

## License and Authors

- Licensed [GPL v2](http://choosealicense.com/licenses/gpl-2.0/)
- Author:: [Nitzan Raz](https://github.com/BackSlasher) ([backslasher](http://backslasher.net))
