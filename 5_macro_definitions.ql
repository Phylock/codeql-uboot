import cpp

from Macro m
where m.getName().regexpMatch("^ntoh(?:s|l{1,2})$")
select m, "Find all ntoh* macros"


