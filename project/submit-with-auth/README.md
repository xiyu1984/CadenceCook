# submit with authority
## Introduction

There is no `msg.sender` in flow([details](https://docs.onflow.org/cadence/msg-sender/#gatsby-focus-wrapper)). But in some situations, the 'message' receiver really need to know the souece of the 'message'. 

So I made a mechanism to implement this, maybe it can be considered as a "design pattern". Generally speaking, the core of this pattern is `Authority Callback`.

Details could be seen at [SubmitAuthor.cdc](https://github.com/xiyu1984/CadenceCook/blob/main/project/submit-with-auth/SubmitAuthor.cdc).
