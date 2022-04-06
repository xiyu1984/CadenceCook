import MultiSignatureFactory from 0x33a8abe2196c9e15

access(all) contract Example{
    pub struct MyData{
      pub var s: String;
      init(){
        self.s = "Hello example!";
      }
    }

    pub event execEvent(res: String)

    pub resource ExaMultiSign: MultiSignatureFactory.MultiSignRscEXEC{

        init(){
            
        }

        access(contract) fun multiSignRscEXEC(inputs: AnyStruct?): AnyStruct?{
            if (nil == inputs){
                log("data failed!");
            }

            // It's important to use `inputs!`, or else the downcast will be failed
            let md: MyData? = inputs! as? MyData;
            if let md_v = md{
                emit Example.execEvent(res: md_v.s);
            }

            return inputs
        }
    }

    pub fun createExaMultiSign(): @ExaMultiSign{
        return <- create ExaMultiSign()
    }
}