/**
 * @kind path-problem
 */

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class NetworkByteSwap extends Expr {
  NetworkByteSwap() {
    exists(MacroInvocation invocation |
      invocation.getMacroName().regexpMatch("^ntoh(?:s|l{1,2})$") and
      this = invocation.getExpr()
    )
  }
}

class Config extends TaintTracking::Configuration {
  Config() { this = "NetworkToMemFuncLength" }

  override predicate isSource(DataFlow::Node source) { source.asExpr() instanceof NetworkByteSwap }

  override predicate isSink(DataFlow::Node sink) {
    //void *memcpy(void *dest, const void *src, size_t n);
    exists(FunctionCall c |
      c.getTarget().getName() = "memcpy" and
      sink.asExpr() = c.getArgument(2)
    )
  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"
