import HelloWorld from 0x01

transaction {

  prepare(acct: AuthAccount) {}

  execute {
    log(HelloWorld.addToMemberRes(Key: 1, outName: "hello111", outInfo: "world111"))
    log(HelloWorld.addToMemberRes(Key: 2, outName: "hello222", outInfo: "world222"))
    log(HelloWorld.addToMemberRes(Key: 3, outName: "hello333", outInfo: "world333"))
    log(HelloWorld.getMemberRes(Key:1))
    log(HelloWorld.getMemberRes(Key:2))
    log(HelloWorld.getMemberRes(Key:3))

    HelloWorld.setMemberResInfo(Key: 4, outInfo: "fly")
    HelloWorld.setMemberResInfo(Key: 1, outInfo: "air plane")
    log(HelloWorld.getMemberRes(Key:1))
    log(HelloWorld.getMemberRes(Key:4))
  }
}