import cpp

class NetworkByteSwap extends Expr {
  NetworkByteSwap() {
    exists(MacroInvocation invocation |
      invocation.getMacroName().regexpMatch("^ntoh(?:s|l{1,2})$") and
      this = invocation.getExpr()
    )
  }
}

from NetworkByteSwap n
select n, "Network byte swap"
