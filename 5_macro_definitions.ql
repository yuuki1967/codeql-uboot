import cpp
from Macro m
where m.getName() in [ "ntohs", "ntohl", "ntohll"] 
select m, "macros ntohs, ntohl, ntohll"
/*
from Macro m
where m.getName().regexpMatch("ntoh[s|l]l*+")  
select m, "macros ntohs, ntohl, ntohll"
*/