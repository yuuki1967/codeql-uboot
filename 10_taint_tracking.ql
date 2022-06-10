import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class NetworkByteSwap extends Expr {
  NetworkByteSwap () {
    // TODO: replace <class> and <var>
    exists(MacroInvocation mi |
      // TODO: <condition>
      mi.getMacroName().regexpMatch("(ntoh|ntohll|ntohs)") |
      this = mi.getExpr()
    )
  }
}

class Config extends TaintTracking::Configuration{
    Config() { this = "NetworkToMemFuncLength"}
    override predicate isSource(DataFlow::Node source){
        source.asExpr() instanceof NetworkByteSwap 
    }
    override predicate isSink(DataFlow::Node sink){
        exists(FunctionCall fcn |
            sink.asExpr() = fcn.getArgument(2) and
            fcn.getTarget().hasName("memcpy")
        )
    }
}

from Config cfg, DataFlow::PathNode source,  DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"
