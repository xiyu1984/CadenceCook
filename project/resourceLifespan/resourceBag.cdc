access(all) contract ResBag{
    
    pub event outPutEvent(info: String);
    
    pub resource Res1{
        priv let s: String;
        // add field after `remove`
        // priv let n: UInt128;

        // add field to test update
        // priv let n2: UInt128;

        pub init(){
            self.s = "Hello, uuid is: ";
            // add field after `remove`
            // self.n = 128;

            // add field to test update
            // self.n2 = 1282;
        }

        pub fun getInfo(): String{
            var outS = self.s.concat(self.uuid.toString());
            
            emit outPutEvent(info: outS);

            return outS;
        }
    }

    pub fun createRes1(): @Res1{
        return <- create Res1();
    }
}