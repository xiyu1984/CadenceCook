access(all) contract HelloWorld {

    pub resource SimpleRes{
        priv let s: String;

        access(contract) init(in_s: String){
            self.s = in_s;
        }

        pub fun getS(): String{
            return self.s
        }
    }

    pub fun createSRes(inputS: String) : @SimpleRes{
        return <- create SimpleRes(in_s: inputS)
    }
}
