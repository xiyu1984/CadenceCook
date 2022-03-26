import MultiSignatureFactory from 0x01

access(all) contract Example{
    pub struct MyData{
      pub var s: String;
      init(){
        self.s = "Hello example!";
      }
    }

    pub resource ExaMultiSign: MultiSignatureFactory.MultiSignRscEXEC{
        access(contract) fun multiSignRscEXEC(inputs: AnyStruct?): AnyStruct?{
            let md: MyData? = inputs as? MyData;
            return md!
        }
    }
}