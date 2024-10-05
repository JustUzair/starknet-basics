# Getting started with Cairo for beginners

As you may be aware I posted this week that I will learn cairo and starknet for a private audit at @NethermindEth, and I back my words and I am still learning advanced stuff and working overtime.

I have made quite some progress since my first tweet about it, and I wish to help others learn it soon as well.

I dedicated hours of time just reading the docs for cairo, starknet, scarb, etc and I have narrowed down important concepts to make it easy to for beginners to start learning.

Before starting, save this thread and share it with your friends or colleagues who are learning or wanting to learn cairo in the future.

Pre-requisites:
Rust 🦀 (Not necessary but speeds up the learning process if already known)

1. Anatomy of the Cairo Contracts.

   - `1.1` Each cairo contract needs to have an interface/blueprint of the contract defined beforehand, it defines the functions in advance that will be known to the outside world.
     The interface is defined by annotating a trait with #[starknet::interface].
     [1.1.1 SS cairo interface simple storage]

     This can be overcome by simply using #[generate_trait], which tells the compiler to generate the corresponding trait definition.
     [1.1.2 SS cairo generate_trait]

   All the functions of the trait are considered as public functions that are callable from outside world.

   NOTE 📝: constructor and internal functions are not a part of the trait/interface.

   All the contract interfaces use a generic type of self parameter that represents the generic contract state denoted by TContractState (can be named anything).

   - `1.2`

2. Storage
   `2.1` The Storage struct is a struct like any other, except that it must be annotated with the #[storage] attribute

   [2.1.1 SS simple storage layout]

   `2.2` Reading from and writing to storage state.
   To read the new value we call the read() function and write() to modify the storage.
   For more advanced storage layout refer to : https://book.cairo-lang.org/ch14-01-00-contract-storage.html#storing-custom-types-with-the-store-trait

   [2.1.2 SS simple read write operation]

3. Functions
   - `3.1` Before diving into functions, it's important to understand the snapshots and refernces.
     - `3.1.1` A snapshot is an immutable view of a value at a certain point in time.
       Snapshots are defined using @, when self is a snapshot of ContractState, only read access is allowed.
       Any function that defines the state with a snapshot is treated as view function.
     - `3.1.2` A refernce type of ContractState on the other hand implies that the state may be modified by the function.
   - `3.2` Visibility of the functions:
     - `3.2.1` External/Public functions:
     - The functions that are annotated with #[abi(embed_v0)] or #[external(v0)] are treated as external functions
     - `3.2.2` Internal/Private - On the other hand the function or the group not marked with any of the abi-embed or external annotations are treated as internal/private by default
     - NOTE 📝: It is important to note that internal and private are used interchangably in cairo.
       Refer to more advanced annotations here: https://book.cairo-lang.org/ch14-02-contract-functions.html#abiper_item-attribute
4. Events and Errors

   - `4.1` An event is defined by declaring an Enum first and then adding all the events and their corresponding types to that enum. Also the enum must be annotated with [derive(starknet::Event)]

     Event data can be annotated by #[key] to filter the data on explorer, similar to indexed in solidity

     Another annotation besides key is #[flat], which essentially flattens the complex types for example nested enums.

     Events are emitted using self.emit(EventName)

Yay you made it till the end 🥳🎉
Now take a look at the contract in the image that combines all the concepts and puts it into a single, easy-to-understand contract.

You can also view the contract here: [Link]
[SS NameRegistry.sol]

Here is the github repo with documentation and all the code:
[github-repo]
