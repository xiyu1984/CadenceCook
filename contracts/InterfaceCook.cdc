

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
}