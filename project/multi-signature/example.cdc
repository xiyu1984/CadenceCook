import MultiSignatureFactory from 0x01

access(all) contract Example{
    pub struct MyData{
      pub var s: String;
      init(){
        self.s = "Hello example!";
      }
    }

    pub resource ExaMultiSign: MultiSignatureFactory.MultiSignRscEXEC{

        init(){
            
        }

        access(contract) fun multiSignRscEXEC(inputs: AnyStruct?): AnyStruct?{
            // if (nil == inputs){
            //     log("data failed!");
            // }

            // It's important to use `inputs!`, or else the downcast will be failed!
            let md: MyData? = inputs! as? MyData;
            return inputs
        }
    }

    pub fun createExaMultiSign(): @ExaMultiSign{
        return <- create ExaMultiSign()
    }
}