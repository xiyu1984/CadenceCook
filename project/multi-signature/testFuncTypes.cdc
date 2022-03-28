// **
// This contract is for testing `Function types` used in `multi-sign proposals` 
// **
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

    pub resource interface ReeeesIF{
        pub fun funcInRes(): String;
        access(contract) fun funcInContract(): String;
    }

    pub resource Reeees: ReeeesIF{
        pub fun funcInRes(): String{
            return "Hello resource!"
        }

        pub fun funcInChild(): String{
            return "Hello Child!"
        }

        access(contract) fun funcInContract(): String{
            return "Only called from contract!"
        }
    }

    // `priv` fun cannot be accessed directly, but can be returned ad `Function types`
    priv fun testFunc(data: AnyStruct): AnyStruct{
        let myDataOpt = data as? MyStr;
        let myData = myDataOpt!
        let myRet = MyRst(oName: myData.name, oID: myData.id, oInfo: myData.name);

        return myRet
    }

    // return `tFunType.testFunc` as `Function types`, although it's a `priv` access
    pub fun getPrivFunc(): ((AnyStruct):AnyStruct){
        return tFunType.testFunc
    }

    pub fun testReeeesFI(){
        self.account.save(<- create Reeees(), to: /storage/reeees);
        // `auth` can upcast and downcast completely freely! 
        self.account.link<auth &AnyResource{ReeeesIF}>(/private/reeees, target: /storage/reeees);
    }

    pub fun visitCAccess(resRef: &{ReeeesIF}): String{
        return resRef.funcInContract()
    }
}