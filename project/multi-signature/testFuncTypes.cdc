access(all) contract tFunType{
    pub struct MyStr{
        pub let name: String;
        pub let id: UInt128;
        pub let ary: [String];
        pub let dct: {UInt: String};

        init(){
            self.name = "luna";
            self.id = 99;
            self.ary = ["coffee"];
            self.dct = {88: "good"};
        }
    }

    pub struct MyRst{
        pub let name: String;
        pub let id: UInt128;
        pub let info: String;

        init(oName: String, oID: UInt128, oInfo: String){
            self.name = oName;
            self.id = oID;
            self.info = oInfo;
        }
    }

    pub fun testFunc(data: AnyStruct): AnyStruct{
        let myDataOpt = data as? MyStr;
        let myData = myDataOpt!
        let myRet = MyRst(oName: myData.name, oID: myData.id, oInfo: myData.name);

        return myRet
    }
}