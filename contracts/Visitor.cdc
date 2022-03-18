import InterfaceCook from 0x02

access(all) contract Visitor {

  // Declare a public field of type String.
  //
  // All fields must be initialized in the init() function.
  access(all) let greeting: String

  // The init() function is required if the contract contains any fields.
  init() {
      self.greeting = "Hello from account 3!"
  }

  // Public function that returns our friendly greeting!
  access(all) fun hello(): String {
      return self.greeting
  }

  pub fun get_pub_cap(): String{
      let pubKey = getAccount(InterfaceCook.getAddress());
      let cerCap = pubKey.getCapability<&InterfaceCook.Cerrect>(/public/oneCerrectLink);
      let cerRef = cerCap.borrow()!;

      return cerRef.getInfo()
  }
}
