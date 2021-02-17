curl -X POST -d '{"dpid":14037442450176,      
"match":{"ipv4_src":"100.200.1.0/255.255.255.0","ipv4_dst":"10.20.1.0/255.255.255.0","eth_type":"0x0800"},      
"actions":[{"type": "SET_FIELD", "field": "eth_dst", "value": "c2:02:56:fe:00:00"}, {"type":"OUTPUT","port":2}],"priority":100}' http://localhost:8080/stats/flowentry/add

curl -X POST -d '{"dpid":14037442450176,      
"match":{"ipv4_src":"10.20.1.0/255.255.255.0","ipv4_dst":"100.200.1.0/255.255.255.0","eth_type":"0x0800"},      
"actions":[{"type": "SET_FIELD", "field": "eth_dst", "value": "c2:01:56:ee:00:00"}, {"type":"OUTPUT","port":1}],"priority":100}' http://localhost:8080/stats/flowentry/add

curl -X POST -d '{"dpid":14037442450176,      
"match":{"in_port": 1, "eth_type":"0x0800"},      
"actions":[{"type": "SET_FIELD", "field": "eth_dst", "value": "c2:02:56:fe:00:20"}, {"type":"OUTPUT","port":4}],"priority":50}' http://localhost:8080/stats/flowentry/add

curl -X POST -d '{"dpid":14037442450176,      
"match":{"in_port": 1, "eth_type":"0x0806"},      
"actions":[{"type": "SET_FIELD", "field": "eth_dst", "value": "c2:02:56:fe:00:00"}, {"type":"OUTPUT","port":2}],"priority":50}' http://localhost:8080/stats/flowentry/add

curl -X POST -d '{"dpid":14037442450176,      
"match":{"in_port": 3, "eth_type":"0x0800"},      
"actions":[{"type": "SET_FIELD", "field": "eth_dst", "value": "c2:02:56:fe:00:20"}, {"type":"OUTPUT","port":4}],"priority":50}' http://localhost:8080/stats/flowentry/add

curl -X POST -d '{"dpid":14037442450176,      
"match":{"in_port": 3, "eth_type":"0x0806"},      
"actions":[{"type": "SET_FIELD", "field": "eth_dst", "value": "c2:02:56:fe:00:20"}, {"type":"OUTPUT","port":4}],"priority":50}' http://localhost:8080/stats/flowentry/add

curl -X POST -d '{"dpid":14037442450176,      
"match":{"in_port": 2, "eth_type":"0x0800"},      
"actions":[{"type": "SET_FIELD", "field": "eth_dst", "value": "c2:01:56:ee:00:20"}, {"type":"OUTPUT","port":3}],"priority":50}' http://localhost:8080/stats/flowentry/add

curl -X POST -d '{"dpid":14037442450176,      
"match":{"in_port": 2, "eth_type":"0x0806"},      
"actions":[{"type": "SET_FIELD", "field": "eth_dst", "value": "c2:01:56:ee:00:00"}, {"type":"OUTPUT","port":1}],"priority":50}' http://localhost:8080/stats/flowentry/add

curl -X POST -d '{"dpid":14037442450176,      
"match":{"in_port": 4, "eth_type":"0x0800"},      
"actions":[{"type": "SET_FIELD", "field": "eth_dst", "value": "c2:01:56:ee:00:20"}, {"type":"OUTPUT","port":3}],"priority":50}' http://localhost:8080/stats/flowentry/add

curl -X POST -d '{"dpid":14037442450176,      
"match":{"in_port": 4, "eth_type":"0x0806"},      
"actions":[{"type": "SET_FIELD", "field": "eth_dst", "value": "c2:01:56:ee:00:20"}, {"type":"OUTPUT","port":3}],"priority":50}' http://localhost:8080/stats/flowentry/add
