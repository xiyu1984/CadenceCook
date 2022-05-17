# <Project name>
**Dante Network**
# Grant category
- [x] Product bounty

# Description
Dante Network is a middleware to empower multi-chain ecosystems to interconnect and interoperate with each other in web3.

In Dante Network, we define and offer a general protocol stack to realize multi-chain interoperability and interconnection. This will bring innovative experiences in web3, just as the Internet protocol is for today’s internet. With this infrastructure, participants in web3 can make universal message transmission and contract invocation across blockchain networks.

We are applying for this grant to build our protocol stack on Flow, which will allow  Flow resources and functions to be accessed by the entire Web3 world. 

## Problem statement
* **Target audience**: In the early stage, the main target audience is the dApp developers. With the development of Dante Protocol Stack, there will be several dApps based on it, so the ordinary users will have indirect access to Dante's services.
* **Evidence for the need**: 
    * since there are more blockchains than BTC, cross-chain is a topic on the agenda, whether it is a centralized solution, such as CEX, or decentralized solutions, such as various cross-chain bridges, all prove that. In the early days, cross-chain mainly focused on the Token, but as the block chain function and application scenera became richer, more comprehensive cross-chain requirements have been proposed. Currently, there are numbers of projects focusing on multi-chain interoperability, which have been recognized by the market, such as Axelar, Layerzero, and even ChainLink, which fully demonstrate the potential of this field.  
    * The horizontal expansion of blockchain is an inevitable trend, which has been proved by the rise of sharding and Layer2. However, sharding and Layer2 can only solve the communication and collaboration problems between isomorphic chains.  But in fact, there are more heterogeneous chains in the Web3 world, and there is a greater market space and necessity to solve the communication and collaboration problems between them.  
    * Apart from the observation at the macro level, we have also had in-depth communication with many DApp projects at the micro level. Many of them believe that cross-chain interoperability will bring better composability to DApps, especially for DeFi projects which were famous for composability, especially in today's increasingly obvious differentiation of each public chain.  The composability of multiple chains opens up more possibilities for them, and this has been recognized by many projects. 
    * Flow's resource-oriented model allows for a new interpretation of digital asset ownership, for example, in the NFT use case, Flow demonstrates a capability that cannot be replaced by ERC721: the asset truly belongs to the individual, rather than relying on a smart contract to keep score. As we all know, smart contracts can be destroyed. We think this feature should be extended to the entire web3 world, as we found evidence in real life: we can have cash at our disposal from the bank, not because the bank failed and made it unusable.

* Target: We will build the multi-chain protocol stack as well as its concrete implementation on Flow.
    * Firstly, Flow provides a resource-oriented programming paradigm, the implementation of the Dante protocol on Flow will be an independent Flow resource called a “multi-chain communication resource” for resources so that any resource on Flow could be accessible to many other chains in the whole Web3 world. 
    * Secondly, the Dante protocol stack will be implemented as smart contracts deployed on other chains. With this middleware, dApps in multi-ecosystems can send or receive general messages, to or from contracts deployed on other chains. Besides, contracts deployed on different chains can call each other as conveniently as they doing their nativechain. So the smart contract and resources on Flow can also be used by users of other chains no matter where they are.
    * Thirdly, off-chain routers are built to make the underlying information routing. Anyone can participate in Dante Network by deploying a "router" with their own private key.
    * Fourthly, we will provide SDKs covering multiple technology stacks for dApp developers to make multi-chain interoperations more convenient and straightforward. Considering Flow‘s unique and charismatic programming paradigm, we will release a specific SDK  to help maximize the effectiveness of Flow.
* Highlights
    * General:
        * Barrier-free multi-chain ecosystem Collaboration (Including multi-chain Token transactions and multi-chain interoperability): Provision of a general data verification protocol to execute token circulation, comprehensive information sensing, and dApps interoperability among multiple chains,  like the “Blocknet”.
        * A dynamic balance of security, scalability, and decentralization: Provision of an SQoS mechanism that can be adapted to various scenarios, similar to the QoS in TCP/IP protocol cluster.

    * Special for Flow:
        * The Dante protocol stack is built as resources on Flow, which can be independently integrated into other resources to make them globally accessible from anywhere in the Web3 world. These "global resources" are unaffected by each other, which implies that even if one of them is faulty (e.g., suffers a malicious attack), the impact is contained within its own domain.

## Proposed solution
Architecture

![image](https://github.com/dantenetwork/Pitch-Deck/blob/main/images/%5BEN%5DDante%20Pitch%20Deck3.7_06.jpg)

Generally, the protocol stack includes three layers, the “Service Presentation Layer”, the “Security Quality Layer”, and the “Consensus Verification Layer”. We make a concrete implementation of these 3 layers.

The “Service Presentation Layer” is at the top of the protocol stack. It defines the message organization protocol, the invocation method, and the service interfaces, which is similarto “RESTful Web Service” and “HTTPS” in web2. This makes the development of web3 dApps easier. Our protocol stack incorporates the implementation of transaction privacy, to guarantee the protection of on-chain behavior and data.

The “Security Quality Layer” is the second layer, which defines a cluster of security mechanisms that can be configured according to the demand of the application. “SQoS” defines the concrete mechanisms of routing, verification, privacy, authority, etc. This can be analogous to the “QoS” in TCP/IP protocol cluster.

The “Consensus Verification Layer” is the bottom layer of the protocol stack, designed specifically for web3. The verification algorithms include the commitment and belief verifications that are applicable to major  ranges of scenarios in web3. The protocol also includes algorithms for evaluation, incentives, challenge, as well as a “Parallel Route Scheduling” algorithm that is responsible for router selection. At the bottom of this layer, they specify a “Physical” protocol, similar to the “Physical Layer” of the OSI model,  that defines the standard behavior of the routing node (officially named “Adaption node”).

That’s an overview of the protocol stack in Dante Network. We believe it can be regarded as Web3’s  “Internet protocol”, the “Blocknet Protocol” that connects chains together. The protocol stack implementation, along with off-chain routers,  can be embedded in public chains as a smart contract. That’s similar to how operating systems use the embedded TCP/IP protocol cluster to build a computer network with routers.

Flow pioneered a unique approach to smart contract development.
The dApp programming language for Flow is called “Cadence”. It is a resource-oriented language and contracts are just a definition. Meaning that, in order to improve access control, data and assets on Flow should be expressed as resources associated with the user’s account. This is of great importance  because even if the related contract was compromised by malicious attackers, the assets remain under the control of their real owners. Besides, the impact of a potential attack would be very limited since the contracts on Flow have very few functions. This is why we build our protocol stack as a resource implementing all the underlying abilities of multi-chain communications. The details can be seen in the following section @[Ecosystem Fit].

More details of Dante Network are here:
* [Project Demo Video](https://www.youtube.com/watch?v=CYXx4O8Xgcs)
* [Pitch Deck & White Paper](https://github.com/dantenetwork/Pitch-Deck) 
* [Website](https://www.dantechain.com/) 

## Impact
We believe we can bring in some benefits to Flow as follows:
* Enable more users to understand Flow, through the Omnichain products with more application attributes such as NFT and Swap.
* Lower the technical barrier for developers to engage in Flow.
* Make it easier for users belonging to other public chains to use Flow without leaving the environment they are familiar with. This will bring more users to Flow.

In regular on-chain programming paradigms, the on-chain part of the protocol stack is implemented just as smart contracts, and it operates as a public gateway of each ecosystem to manage all communications and multi-chain contracts calls out and into it.

On Flow, things become interesting and special. The Dante protocol stack’s implementation on Flow is as follows: 

![Flow](https://github.com/dantenetwork/Pitch-Deck/blob/main/images/Flow.png)

We will build a factory contract to manage the creation of the “Multi-chain Communication Resource”(abbreviated  “MCR”), which can be integrated into other resources to help them communicate with other chains. dApps resources or contracts can call the factory contract to generate an individual MCR for them, and use the instance of the ‘Sender’ resource to send messages to other chains or use the instance of the ‘Receiver’ resource to receive messages from others. The ‘Sender’ and 'Receiver’ instances are bound to a single dApp, but MCR instances in different DApps will not affect each other. Non-rigorously, this can be compared to encapsulating an individual dApp (with its contracts and resources) along with a concrete instance of MCR in a Docker container.

The grants will be utilized to develop our multi-chain product on Flow with following abilities: 

**Omnichain resource**

Dante Protocol stack deployed on Flow (as we mentioned above) to help resources on Flow become Omnichain resources.The omnichain resource will bring more possibilities to Web3. 
For example, people can build an Omnichain NFT in this way, which can synchronize information and operations of NFTs with the Dante Protocol stack; 
* On one hand, NFTs and the related operations on Flow can be accessed and executed by authorized users on other chains. Users can transfer, combine, show, swap, or do anything supported by Flow on chains such as Ethereum, BNB, Avalanche, etc. And operations on Flow will be synchronized to those chains.
* On the other hand, let NTF published on other chains be “engraved” on Flow, so these NFTs can have many unique operations which can only be adopted in Flow which will bring some new experiences for NFT owners and issuers.

**Omnichain Swap**

Users  can build an Omnichain Swap based on Dante, which can help NFTs on Flow be exchanged with users inside and outside Flow.
* Firstly, support FT swap between Flow and some other chains;
* Secondly, support NFT swap between Flow and some other chains.

**Developer Docs**

Moreover, grants will be used as incentives for providing dev docs about how to use the Dante protocol stack in the technology stack of Flow and some related Flow dev skills for developers.


# Milestones and funding

## Overview
* Total Estimated Duration: 6 months
* Full-Time Equivalent (FTE):  2.5 FTE
* Total Costs: Flow worth $15,000
## Milestone 1
The service presentation layer,  message verification & router credibility evaluation algorithms, basic off-chain routers, and basic SDK.
### Information:
* Estimated duration: 3 months
* FTE:  2.5
* Costs: Flow worth $5,000
* License: GPLv3
### Outputs:
* Documentation: We will provide a basic tutorial to explain how to use the Demos and the SDKs.
* Testing Guide: Core functions will be fully covered by unit tests to ensure functionality and robustness. In the guide, we will describe how to run these tests.
* Functions: 
    * (smart contracts) Service presentation layer: Developing and testing Service presentation layer on Flow; Demo for communication and interoperability between  Flow and some EVM chains (such as ETB, BSC).
    * (smart contracts) Message verification algorithm: Developing and testing verification algorithms of the consensus verification layer on Flow; Verification-related contracts deployment on testnet. 
    * (smart contracts) Router credibility evaluation algorithm: Developing and testing the credibility evaluation algorithms of the consensus verification layer; Selection of growth function and decrease function suitable for on-chain calculation is the key point; Router behavior evaluation contracts deployment on testnet; 
    * (off-chain routers) General message sharing: Developing and testing the basic abilities of the off-chain router, including general message encoding and decoding, message delivery between Flow and some EVM chains; Demo.
* SDK: general message sharing
    * Build an initial  SDK including a general message sending and receiving interface.
* Demo:
    * An NFT demo: NFT deployed on Flow (testnet) can be accessed (displayed and transferred) by the OpenSea on ETH (testnet) through Dante protocol stack; 

## Milestone 2
Parallel router scheduling algorithms, SQoS, off-chain routers, SDK, testnet.
### Information:
* Estimated duration: 3 months
* FTE:  2.5
* Costs: Flow worth $5,000
* License: GPLv3
### Outputs:
* Documentation: We will provide a basic tutorial that explains how to use theDemos and the SDKs.
* Testing Guide: Core functions will be fully covered by unit tests to ensure functionality and robustness. In the guide, we will describe how to run these tests.
* Functions:
    * (smart contracts) Parallel router scheduling algorithm: Developing and testing parallel router scheduling algorithms of the consensus verification layer; Suitable on-chain sampling algorithm is the key point; Scheduling contracts deployment on Flow (testnet).
    * (smart contracts) SQoS: Developing and testing the SQoS (Security Quality of Service) mechanisms including hidden & reveal, challenge confirm, verification threshold, authority context, etc.
    * (off-chain routers) SQoS: Developing and testing the SQoS (Security Quality of Service) mechanisms including hidden & reveal, challenge confirm, verification threshold, authority context, etc.
* SDK: contracts invocation; SQoS
    * Interface of contracts invocation between Flow and some EVM chains.
    * Settings of SQoS.
* Demo:
    * A multi-chain SWAP demo deployed on Flow (testnet) and some EVM chains. Swap FLOW (testnet) with ETH(testnet) or BNB(testnet) through Dante protocol stack.

## Milestone 3
Complete the Omnichain NFT and Swap product. 
### Information:
* Estimated duration: 3 months
* FTE:  2.5
* Costs: Flow worth $5,000
* License: GPLv3
* Outputs:
    * An Omnichain NFT be able to synchronize information and operations of NFTs using Dante between Flow and some other chains:
    * Define an NFT proxy contract and related resources on source chains to synchronize NFT(common NFT combined with Dante) actions on Flow to other chains;
    * Build an NFT proxy contract on source chains to synchronize NFT actions on other chains to the related NFT on Flow. 
    * An Omnichain SWAP for FT and NFT chains transparent: 
    * Build an Omnichain market (DApp including Marketing contracts and resources defined on Flow and contracts deployed on some other chains, along with a web UI);
    * Order book based FT swap in the Omnichain market;
    * Order book based NFT swap in the Omnichain market.

# Technology Team
Jason(CEO)
* Post graduated from Shanghai Jiao Tong University
* Major in software enginering
* Over 10 years of working experience; senior practitioner in blockchain/information security
* Responsible for participating in a number of national information security research projects
* Head of node service provider
* Experienced in operating nodes of many large projects
* Rich experience in blockchain project incubating and operation

Shawn Z (Tech leader)
* Post graduated from University of Electronic Science and Technology of China
* Major in Information Security
* Expert in privacy computing, blockchain, and artificial intelligence
* Responsible for or participated in a number of national information security research projects
* Worked for a State-owned enterprise (Fortune 500) engaged in the security business for 10+ years.
* Full-stack engineer in information security, AI, blockchain, etc.
* Hackathon winner as a team tech leader: [Near MetaBuild Hackathon] (https://devpost.com/software/universal-trusted-cross-chain-bridge ), [PlatON Dorahacks] (https://forum.latticex.foundation/t/topic/5676 );
Github: https://github.com/xiyu1984 

Zack W (Full-stack Dev in web3, core dev in Dante Network)
* Post graduated from Xiamen University
* Major in Computer Science & PM
* EOS, PlatON technical community senior participant (output around 40 technical articles, help EOS and PlatON fix many bugs).
* Technical mentor for EOS 1st Hong Kong Hackathon Live.
* Technical leader of EOS Genesis node ‘eosiomeetone’ which was the largest node in Asia in terms of traffic when the main network was launched, with QPS 8k+.
* Senior full-stack engineer (worked in Qunar, Snowball).
* Hackathon winner: [Near MetaBuild Hackathon] (https://devpost.com/software/universal-trusted-cross-chain-bridge), [PlatON Dorahacks] (https://forum.latticex.foundation/t/topic/5676);
* Github main page: https://github.com/wuyahuang .
* Technical articles: https://github.com/meet-one/documentation .

George H (Full-stack Dev in web3, core dev in Dante Network)
* Bachelor of Shanghai Jiao Tong University
* Major in Software Engineering
* Senior participant of PlatON technical community ported Chainlink project for PlatON and exported several technical articles.
* Built and maintained Polkadot, Kusama, PlatON, Ethereum2.0, ChainX, and other project nodes
* Crust, Phala project node data center leader, responsible for project operations and maintenance, and the development of operations and maintenance-related tools.
* 10 years as a full-stack engineer in finance, games, education, etc.
* Hackathon winner: [Near Metabuild Hackathon] (https://devpost.com/software/universal-trusted-cross-chain-bridge), [PlatON Dorahacks] (https://forum.latticex.foundation/t/topic/5676);
* Github: https://github.com/virgil2019 .
* Mail: hht2015ily@gmail.com

Kay L (Full-stack Dev in web3, core dev in Dante Network)
* Post graduated from Harbin University of Science and Technology
* Major in Software Engineering
* Development of a State-owned enterprise medical alliance chain, as well as the construction and maintenance of a distributed storage network and related SDK.
* Years of blockchain experience, an active participant in EOS, PlatON, and other communities, publishing technical articles and fixing bugs.
* Participate in EOS node maintenance, and EOS DAPP development.
* Hackathon winner: [Near Metabuild Hackathon] (https://devpost.com/software/universal-trusted-cross-chain-bridge), [PlatON Dorahacks] (https://forum.latticex.foundation/t/topic/5676);
* GitHub: https://github.com/kay404 .
* Mail: kay20475@gmail.com

James F (Full-stack Dev in web3, core dev in Dante Network)
* Bachelor of  University of Electronic Science and Technology of China
* Major in Computer Science
* Over 10 years of working experience in various aspects of computer programming, analysis, development, and testing.
* EOS, Fluence, Nervos technical community participant.
* Full-stack engineer (worked in Go/Rust/C++/Javascript)
* Hackathon winner: [FluenceLabs gitcoin hackathon] (https://gitcoin.co/issue/fluencelabs/sovereign-data-hackathon/1/100026738 ), [nervos gitcoin hackathon] (https://www.nervos.org/blog/nervos-gitcoin-hackathon-winners-announced ).
* Github: https://github.com/fsy412 

Joseph N (Backend Dev, API Engineer, DevOps, front dev in Dante Network)
* Master in Software Engineering from UESTC
* 10+ years experience in general, with +8 in software development for companies mainly in financial related institutions including, but not limited to banking, consumer credits and online banking. 
* Extensive expertise in large system architecture development and administration, as well as cloud based microservices architectures. 
* DevOPs (Docker, Docker-compose)
* Proven ability to work in a group and adapt to technological change. 
* Interest in blockchain development
* Technical content writer
* Github: https://github.com/roinujsupport4u/
* Mail: josephjuniorn@gmail.com
