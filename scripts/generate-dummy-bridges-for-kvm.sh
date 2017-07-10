#!/bin/bash

cat << EOF > iface-template.xml
<interface type='bridge' name='brNUMBER'>
  <start mode='onboot'/>
  <protocol family='ipv4'>
    <ip address='10.0.92.NUMBER' prefix='24'/>
  </protocol>
  <protocol family='ipv6'>
    <autoconf/>
  </protocol>
  <bridge stp='off' delay='0.00'>
  </bridge>
</interface>
EOF

for i in $(seq 1 200); do cat iface-template.xml |sed -e 's/NUMBER/'$i'/g' > iface-br${i}.xml; virsh iface-define iface-br${i}.xml; done

