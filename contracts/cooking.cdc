// HelloWorld.cdc
//
// Welcome to Cadence! This is one of the simplest programs you can deploy on Flow.
//
// The HelloWorld contract contains a single string field and a public getter function.
//
// Follow the "Hello, World!" tutorial to learn more: https://docs.onflow.org/cadence/tutorial/02-hello-world/

access(all) contract HelloWorld {

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
        var hs = "0123456789";
        var hc = "9876543210";

        hs<->hc

        let ctt = fun(_ s1: String, _ s2: String) : String{
            return s1.concat(s2)
        }

        fun ccFun(_ s: String): ((): String){
            var s_in: String = hs;
            return fun(): String{
                s_in = s_in.concat(s);
                return s_in
            }
        }

        //return ctt(hs, hc).slice(from: 0, upTo: 20)
        let ctt2 = ccFun(hc);
        ctt2();
        return ctt2()
    }
}
