import cpp

class NetworkByteSwap extends Expr {
    NetworkByteSwap () {
        exists(MacroInvocation macroInv | macroInv.getMacro().getName().regexpMatch("ntoh[s|l]l*+") and
        this = macroInv.getExpr()
        )
    }
}

from NetworkByteSwap n
select n, "Network byte swap"