// HelloWorld.cdc
//
// Welcome to Cadence! This is one of the simplest programs you can deploy on Flow.
//
// The HelloWorld contract contains a single string field and a public getter function.
//
// Follow the "Hello, World!" tutorial to learn more: https://docs.onflow.org/cadence/tutorial/02-hello-world/

access(all) contract HelloWorld {

    // User defined data struct
    pub struct MyData{
        pub var id: Int64 
        pub var name: String 

        init(ID: Int64, Name: String){
            self.id = ID;
            self.name = Name;
        }

        pub fun getAllInfo(): String{
            return self.name.concat(self.id.toString())
        }
    }

    pub resource MyRes {
        pub(set) var name: String
        pub(set) var info: String

        init(Name: String, Info: String){
            self.name = Name
            self.info = Info
        }

        // reload of init is not supported yet!
        //init(){
        //    self.name = "";
        //    self.info = "";
        //}

        pub fun getAllInfo(): String{
            return self.name.concat(self.info)
        }

        pub fun setResInfo(Info: String){
            self.info = Info;
        }
    }

    // Declare a public field of type String.
    //
    // All fields must be initialized in the init() function.
    access(all) let greeting: String

    // map resource
    access(all) var dmap: @{Int32: MyRes};

    // The init() function is required if the contract contains any fields.
    init() {
        self.greeting = "Hello, World!";
        self.dmap <- {}
    }

    //destroy(){
    //    destroy self.dmap
    //}

    // Public function that returns our friendly greeting!
    access(all) fun hello(): String {
        pre{
            2 > 1 : "why 2 is not bigger than 1?"
        }
        post{
            result.length > 300 : "length too short!"
        }
        
        var hs = "0123456789";
        var hc = "9876543210";

        hs<->hc

        let ctt = fun(_ s1: String, _ s2: String) : String{
            return s1.concat(s2)
        }

        // `ccFun` is a closure, and the vars(like `s_in`) are like member vars of the closure(like class), 
        // which will be maintained along with the holder of the `ccFun` instance.
        // That is, you can treat `ccFun` instance as `class` objects.
        fun ccFun(_ s: String): ((): String){
            // `s_in` is re-created and maintained every time `ccFun(ss)` is called and assigned.
            var s_in: String = hs;
            return fun(): String{
                s_in = s_in.concat(s);
                return s_in
            }
        }

        //return ctt(hs, hc).slice(from: 0, upTo: 20)
        let ctt2 = ccFun(hc);
        ctt2();
        ctt2();

        // the `s_in` in `ccFun` is re-created and maintained with `ctt3`
        let ctt3 = ccFun(hs);
        ctt3();
        return ctt3()
    }

    access(all) fun visitMyData(): String{
        let mdata: MyData? = MyData(ID: 73, Name: "Hello");

        return mdata!.getAllInfo()
    }

    access(all) fun visitMyResMap(): String{
        var res: @MyRes <- create MyRes(Name: "1", Info: "2");
        res.name = "hello";
        let s = res.getAllInfo();
        destroy  res
        return s
    }

    access(all) fun addToMemberRes(Key: Int32, outName: String, outInfo: String){
        let res <- create MyRes(Name: outName, Info: outInfo);
        let old <- self.dmap.insert(key: Key, <-res);
        destroy  old
    }

    access(all) fun getMemberRes(Key: Int32) : String {
        //var cur_res: @MyRes? <- create MyRes(Name: "", Info: "")
        //cur_res <-> self.dmap[Key]
        //let s = cur_res?.getAllInfo();
        //cur_res <-> self.dmap[Key];
        //destroy cur_res
        //return s ?? "Key not exist!"
        
        // The same as above
        return self.dmap[Key]?.getAllInfo() ?? "Key not exist"
    }

    access(all) fun setMemberResInfo(Key: Int32, outInfo: String) {
        // this works, but there's no exception if `Key` does not exist!
        self.dmap[Key]?.setResInfo(Info: outInfo);
        
        // this dose't work because "cannot assign to optional chaining expression"
        //self.dmap[Key]?.name = ""
    }

    pub event rResult(res: UInt64)

    pub fun testUnsafeRandom(): UInt64{
        emit rResult(res: unsafeRandom())
        return unsafeRandom()
    }

    pub event createEvent(res: String)

    pub fun createMyRes(oName: String, oInfo: String): @MyRes{
        emit createEvent(res: "Creating `MyRes`: Name: ".concat(oName).concat(". Info: ").concat(oInfo))
        return <- create MyRes(Name: oName, Info: oInfo)
    }
}
