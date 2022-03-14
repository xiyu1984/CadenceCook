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
        // 🚧 Status: Field getters and setters are not implemented yet.
        // {
        //     get {
        //         if (self.id < 0){
        //             return 0
        //         }
        //         return self.id
        //     }

        //     set(newId) {
        //         if newId < 0{
        //             self.id = 0;
        //         }
        //         self.id = newId;
        //     }
        // }

        pub var name: String 
        // {
        //     get {
        //         if (self.name.length < 1) {
        //             return "hello world!"
        //         }
        //         return self.name
        //     }

        //     set(newName) {
        //         if (newName.length > 20){
        //             self.name = newName.slice(from: 0, upTo: 20);
        //         }
        //         self.name = newName;
        //     }
        // }

        // 🚧 Status: Synthetic fields are not implemented yet.
        // pub synthetic allInfo: String {
        //     get {
        //         return self.name.concat(self.id.toString())
        //     }
        // }

        init(ID: Int64, Name: String){
            self.id = ID;
            self.name = Name;
        }

        pub fun getAllInfo(): String{
            return self.name.concat(self.id.toString())
        }
    }

    // Declare a public field of type String.
    //
    // All fields must be initialized in the init() function.
    access(all) let greeting: String

    // The init() function is required if the contract contains any fields.
    init() {
        self.greeting = "Hello, World!"
    }

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
}
