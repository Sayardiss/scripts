IP="$1"
KEY='AAAAB3NzaC1yc2EAAAADAQABAAACAQCf34+rFXlwjt3WEng2zh8tMgb75Ojpe4O53jza4MdB0fuKl/aWqD1yrMUiu7gMdYEf09K5x4PYxpzMP57M6Nwfe/Uyuyy0itoM0mWPVsYEokWRDpPYLLJBaXmdJ8RGppOHeil975RwbnAlHomx5ainZ4Xr/O16Ir0ONW8X8PNbXJWJwNa33w8b90fv38PLNDIEgpizSbQ/xkwxmvHBb06jSTg3LmAxtNBP3w1cM9IHiq/tRBsRZtatCB6+JL5v79bnWSL5t22yNR1jwCZljC1wm/o3ysjul35bW885CJyP0hocM9Zi3S3CrJZ/HxZ1LOi+yZz4zrXg3hIsKeU5JHGMtZimLQKEjbc/9s8KbLz+sRZFdcqpAZaQKbYH7v2UOgiY2TAmJnH5gLSm7cmniSkBFR2k3Ud2qItd9SLeH49fLg+MFyb4OIzRIk7PT5YNFw0GsT1jfWzve/0FYj49u8CdmiFEva+K/bvBh974kQXx3t+iZYdKJbRhtiS8OZ30TAgDPYHa3cwEQsnYTBg3gJAmV9ASgqB+PLba5+RRwdjHIdKiQo4tiBrqgvFF3AOkgubWNzbhdyffiK1yRiY3+Uc8tnkOXYBYfUf5c3WMnHSjqMr9zvwzULEsk86EqVH6uNvZ3d3HZIGorARXsuNdtSBnyRREswm7rk39VQUsfM1Jrw=='


ssh-copy-id -o "StrictHostKeyChecking=no" user@${IP}; ssh -o "StrictHostKeyChecking=no" user@${IP} -t "su -c \"echo ssh-rsa $KEY opti >> /root/.ssh/authorized_keys\""