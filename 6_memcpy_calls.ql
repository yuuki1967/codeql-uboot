import cpp

from FunctionCall call, Function fcn
where 
    call.getTarget().hasName("memcpy")
    select call
