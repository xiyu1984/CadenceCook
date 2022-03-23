import HelloWorld from 0x01

access(all) contract WorldVisitor {

  pub fun visiting(): String{
    let sRes <- HelloWorld.createSRes(inputS: "Hello");
    let s = sRes.getS();
    destroy sRes;

    // access control to `init` of resource `SimpleRes` makes it invalid below!
    // let sRes2 <- create HelloWorld.SimpleRes(in_s: "What?");
    // log(sRes2.getS())
    // destroy sRes2;

    return s
  }
}
