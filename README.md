# proxifier-linux
proxyfier alternative for linux using redsocks. Proxify all linux applications through SOCKS4/5, HTTP proxy

## Installation

Install [redsocks](https://github.com/darkk/redsocks#packages).

```
git clone https://github.com/tazihad/proxifier-linux.git
cd proxifier-linux
```

## Usage

1. Setup redsocks.conf (Example config given)  
`/etc/redsocks.conf`
2. Open Terminal and run  
`./start-proxifier.sh`

Done. [Check IP](https://ifconfig.me/)

3. CTRL+Z to exit first script and flush iptables  
`sudo ./stop-proxifier.sh`


More Information:  [redsocks](https://github.com/darkk/redsocks), [superuser](https://superuser.com/a/1402071), [crosp.net](https://crosp.net/blog/administration/install-configure-redsocks-proxy-centos-linux/)
