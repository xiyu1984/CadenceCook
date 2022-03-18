import HelloWorld from 0x01

access(all) contract InterfaceCook {

    pub resource interface BaseIn {
        // there can be no `let` or `var` here
        pub id: Int32;
        pub amount: Int64;

        init(ID: Int32, Amount: Int64){
            pre {
                Amount >= 0:
                        "Invalid `Amount`"
            }
            post {
                (self.id == ID) && (self.amount == Amount) :
                        "Inconsistencies" 
            }
        }

        access(contract) fun withdraw(Amount: Int64) : @{BaseIn}{
            pre {
                Amount > 0: 
                        "Invalid `Amount`"
                self.amount >= Amount:
                        "Not enough"
            }
            post {
                self.amount == before(self.amount) - Amount:
                        "Inconsistencies"
            }
        }

        access(contract) fun deposit(obj: @{BaseIn}){
            pre {
                obj.amount > 0:
                        "Invalid amount of the input"
            }
            post {
                self.amount == before(self.amount) + obj.amount:
                        "Inconsistencies"
            }
        }
    }

    pub resource Cerrect: BaseIn{
        pub var id: Int32;
        pub var amount: Int64;

        init(ID: Int32, Amount: Int64){
            self.id = ID;
            self.amount = Amount;
        }

        access(contract) fun withdraw(Amount: Int64) : @Cerrect {
            self.amount = self.amount - Amount;
            return <- create Cerrect(ID: self.id + 10000, Amount: Amount)
        }

        access(contract) fun deposit(obj: @{BaseIn}){
            if let inputObj <- obj as? @Cerrect{
                self.amount = self.amount + inputObj.amount;
                destroy inputObj;
            }
            else{
                destroy obj;
                panic("cannot deposit token which is not an `Cerrect` token")
            }
        }

        access(contract) fun getInfo(): String {
            return self.id.toString().concat(self.amount.toString())
        }
    }

    access(contract) let myCerrect: @Cerrect;

    init(){
        self.myCerrect <- create Cerrect(ID: 1, Amount: 66);
    }

    pub fun testCerrect(lastWD: Int64) {
        let wdn <- self.myCerrect.withdraw(Amount: 33);

        let otherC <- create Cerrect(ID: 2, Amount: 99);
        self.myCerrect.deposit(obj: <-otherC);

        destroy wdn;

        let wdn2 <- self.myCerrect.withdraw(Amount: lastWD);

        destroy wdn2;
    }

    pub fun getCerrect() : Int64{
        return self.myCerrect.amount
    }

    pub fun getCerrectInfo() : String{
        // `{BaseIn}` it the restriction to the type of outCerrect
        let outCerrect: @Cerrect{BaseIn} <- create Cerrect(ID: 666, Amount: 999);
        // So the line below cannot be compiled
        // let s = outCerrect.getInfo();
        
        let outCerrect2: @Cerrect<- outCerrect;

        let outcRef: &Cerrect = &outCerrect2 as &Cerrect
        let outcRef2: &Cerrect = &outCerrect2 as &Cerrect
        let outcRef3: &Cerrect = &outCerrect2 as &Cerrect

        let s = outcRef.getInfo();

        // the line below here will brings run-time error! But why not the compiler solves it?
        // destroy outCerrect2

        // the lines below works, it's maybe a weakness comparing to Rust
        var s1 = outcRef.getInfo();
        var s2 = outcRef2.getInfo();
        var s3 = outcRef3.getInfo();
        s2 = outcRef2.getInfo();

        destroy outCerrect2
        return s
    }

    pub fun test_cross_contract(): String{
        return HelloWorld.hello()
    }

    pub fun test_account_storage(): String{
        let s_path: StoragePath = /storage/oneCerrect;
        self.account.save(<- create Cerrect(ID: 100, Amount: 99), to: s_path);
        let obj_type = self.account.borrow<&Cerrect>(from: s_path);
        return obj_type?.getInfo() ?? "no resources stored!"
    }

    pub fun test_account_link(): String{
        let s_path: StoragePath = /storage/oneCerrect;
        self.account.save(<- create Cerrect(ID: 256, Amount: 1024), to: s_path);
        let pubKey = getAccount(self.account.address);
        self.account.link<&Cerrect>(/public/oneCerrectLink, target: s_path);

        let cerCap = pubKey.getCapability<&Cerrect>(/public/oneCerrectLink);
        let cerRef = cerCap.borrow()!;

        return cerRef.getInfo()
    }
}