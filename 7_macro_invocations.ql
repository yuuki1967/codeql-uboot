import cpp

from MacroInvocation macroInv
where macroInv.getMacroName().regexpMatch("ntoh[s|l]l*+")
select macroInv