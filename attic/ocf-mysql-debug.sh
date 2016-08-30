export OCF_ROOT=/usr/lib/ocf
export OCF_RESKEY_name="pri_svc_mysql"a
export OCF_RESKEY_
export OCF_RESKEY_binary="/usr/sbin/mysqld"
export OCF_RESKEY_datadir="/var/lib/mysql"
export OCF_RESKEY_user="mysql"
export OCF_RESKEY_log="/var/log/mysql/mysqld.log"
export OCF_RESKEY_pid="/var/run/mysql/mysqld.pid"
export OCF_RESKEY_socket="/var/run/mysql/mysql.sock"
export OCF_RESKEY_config="/etc/my.cnf"

/usr/lib/ocf/resource.d/heartbeat/mysql start
echo $?
