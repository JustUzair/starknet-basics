#[starknet::interface]
trait ISimpleStorage<TContractState> {
    fn set(ref self: TContractState, value: u128);
    fn get(self: @TContractState) -> u128;
}

#[starknet::contract]
mod SimpleStorage {
    use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    #[storage]
    struct Storage {
        value: u128
    }

    #[abi(embed_v0)]
    impl SimpleStorage of super::ISimpleStorage<ContractState> {
        fn set(ref self: ContractState, value: u128) {
            self.value.write(value);
        }
        fn get(self: @ContractState) -> u128 {
            self.value.read()
        }
    }
}
