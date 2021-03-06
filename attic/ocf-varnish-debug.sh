export OCF_ROOT=/usr/lib/ocf
export OCF_RESKEY_name="pri_svc_varnish"
export OCF_RESKEY_config="/etc/varnish/vcl.conf"
export OCF_RESKEY_mgmt_address="10.0.1.104:6082"
export OCF_RESKEY_listen_address="10.0.1.104:80"
export OCF_RESKEY_backend_size="4G"
export OCF_RESKEY_backend_type="file"
export OCF_RESKEY_pid="/var/run/varnishd_pri_svc_varnish.pid"
export OCF_RESKEY_backend_file="/var/cache/varnish/pri_svc_varnish.bin"
/usr/lib/ocf/resource.d/heartbeat/varnish start
echo $?
