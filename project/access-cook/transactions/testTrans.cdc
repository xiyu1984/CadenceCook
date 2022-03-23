import HelloWorld from 0x01
import WorldVisitor from 0x02

transaction {

  prepare(acct: AuthAccount) {}

  execute {
    let sRes <- HelloWorld.createSRes(inputS: "Hello");
    log(sRes.getS())

    destroy sRes

    // access control to `init` of resource `SimpleRes` makes it invalid below!
    // let sRes2 <- create HelloWorld.SimpleRes(in_s: "What?");
    // log(sRes2.getS())
    // destroy sRes2;
    log(WorldVisitor.visiting())
  }
}