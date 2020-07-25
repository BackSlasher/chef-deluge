from __future__ import annotations

import os
import json
from typing import NamedTuple, Dict, Optional

from twisted.internet import reactor
from deluge.ui.client import client
from deluge import common, configmanager

class AuthProvider(NamedTuple):
    host: str
    username: str
    password: str

    @classmethod
    def from_file(klass, config_dir: Optional[str]) -> AuthProvider:
        if config_dir:
            configmanager.set_config_dir(config_dir)
        (username, password) = common.get_localhost_auth()
        return klass(
            host="localhost",
            username=username,
            password=password,
        )

    @classmethod
    def from_login_hash(klass, login_hash: Dict[str, str]) -> AuthProvider:
        assert login_hash.keys() == {"host", "username", "password"}, f"Got bad login_hash keys {login_hash.keys()}"
        return klass(
            host=login_hash["host"],
            username=login_hash["username"],
            password=login_hash["password"],
        )


    def to_login_hash(self) -> Dict[str, str]:
        return {
            "host": self.host,
            "username": self.username,
            "password": self.password,
        }

    

class SettingSetter(object):
  def __init__(self, auth, config):
    self.auth_provider = auth_provider
    self.config = config
    self.changed = False

  def sot_config(self, results):
    self.endSession(None)

  def got_config(self, old_config):
    new_config = self.config
    different_keys = {k for k in new_config.keys() if (k not in old_config) or new_config[k] != old_config[k]}
    filtered_config = {k: new_config[k] for k in different_keys}
    for key in filtered_config.keys():
        print(f"{key}: {old_config.get(key)} -> {filtered_config[key]}")
    if filtered_config:
      self.changed = True
      client.core.set_config(filtered_config).addCallback(self.sot_config)
    else:
      self.endSession(None)

  def on_connect_success(self, result):
    client.core.get_config().addCallback(self.got_config)

  def endSession(self, failure, message=None):
    if failure:
      print(failure)
      reactor.stop()
    else:
      client.disconnect()
      reactor.stop()

  def go(self):
    login_hash = self.auth_provider.to_login_hash()
    cliconnect = client.connect(**(login_hash))
    cliconnect.addCallbacks(self.on_connect_success, self.endSession, errbackArgs=["Connection failed: check settings and try again."])
    reactor.run()
    
    
new_config_hash = json.loads(os.environ['DELUGE_SETTINGS'])
login_hash = json.loads(os.environ.get('DELUGE_LOGIN') or '{}')
config_file = os.environ.get('DELUGE_CONFIG_PATH')

auth_provider = AuthProvider.from_file(config_file) if config_file else AuthProvider.from_login_hash(login_hash)

setter = SettingSetter(auth_provider, new_config_hash)
setter.go()
print("Changes:", setter.changed)
