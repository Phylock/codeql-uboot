import cpp

from MacroInvocation call
where call.getMacroName().regexpMatch("^ntoh(?:s|l{1,2})$")
select call.getExpr()

