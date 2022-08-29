import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class NetworkByteSwap extends Expr {
    NetworkByteSwap () {
        exists(MacroInvocation macroInv | macroInv.getMacro().getName().regexpMatch("ntoh[s|l]l*+") and
        this = macroInv.getExpr() )
    }
}

class Config extends TaintTracking::Configuration {
    Config() { this = "NetworkToMemFunctionLength"}

    override predicate isSource(DataFlow::Node source) {
        source.asExpr() instanceof NetworkByteSwap
    }

    override predicate isSink(DataFlow::Node sink){
        exists(FunctionCall fc|fc.getTarget().hasName("memcpy") and sink.asExpr() = fc.getArgument(2))
    }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"