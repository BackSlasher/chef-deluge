# deluge-cookbook

Helps manage [Deluge](http://deluge-torrent.org/), the BitTorrent client

## Resources

### `deluge_auth`
Defines an auth file (users/passwords) for deluge

* `local_password`: Password for local user
* `users`: Dictionary of `username => password`
* `auth_file`: Location of file. Defaults to resource name

### `deluge_setting`
Defines a single setting for Deluge. 
Actually configured using the console

* `setting`: Setting name. Defaults to resource name
* `value`: Setting value.
* `deluge_console`: Path to deluge binary. Defaults to `deluge-console`, which uses path lookup
* `deluge_config`: Config file. Supplied as an argument for `deluge-console`.

### `deluge_settings`
Collection of settings in a dictionary. Uses `deluge_setting`

* `settings`: Dictionary of `name => value`
* `deluge_console`: Path to deluge binary. Defaults to `deluge-console`, which uses path lookup
* `deluge_config`: Config file. Supplied as an argument for `deluge-console`.

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
