import cpp

from MacroInvocation macroInv
where macroInv.getMacro().getName().regexpMatch("ntoh[s|l]l*+")
select macroInv.getExpr()
