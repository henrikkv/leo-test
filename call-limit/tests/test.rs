use leo_bindings::leo_bindings_sdk::{Account, Client, LocalVM, NetworkVm, VMManager};
use leo_bindings::snarkvm::console::program::ProgramID;
use leo_bindings::snarkvm::prelude::TestnetV0;
use token1_bindings::token1::Token1Aleo;
use token2_bindings::token2::Token2Aleo;
use vault_bindings::vault::VaultAleo;

#[test]
fn test_vault_sim() {
    leo_bindings::utils::init_test_logger();
    let vm = LocalVM::new().unwrap();
    run_vault_tests(vm);
}

#[test]
fn test_vault_net() {
    leo_bindings::utils::init_test_logger();
    let client = Client::new("http://localhost:3030", None).unwrap();
    let vm = NetworkVm::new(&client).unwrap();
    run_vault_tests(vm);
}

fn run_vault_tests<V: VMManager<TestnetV0>>(vm: V) {
    let alice: Account<TestnetV0> = Account::dev_account(0).unwrap();
    let token1 = Token1Aleo::new(&alice, vm.clone()).unwrap();
    let token2 = Token2Aleo::new(&alice, vm.clone()).unwrap();
    let vault = VaultAleo::new(&alice, vm).unwrap();

    let deposit_amount: u128 = 1_000_000;
    let reward_amount: u128 = 10_000_000;

    // token1 works by itself
    token1
        .mint_public(&alice, alice.address(), deposit_amount + reward_amount)
        .unwrap();
    token1
        .transfer_public(
            &alice,
            ProgramID::try_from("vault.aleo")
                .unwrap()
                .to_address()
                .unwrap(),
            reward_amount,
        )
        .unwrap();

    // token1 also works in vault: deposit, withdraw, receive tokens + reward
    vault
        .deposit(&alice, "token1".try_into().unwrap(), deposit_amount)
        .unwrap();
    vault
        .withdraw(&alice, "token1".try_into().unwrap(), deposit_amount)
        .unwrap();

    let alice_balance = token1.get_balance(alice.address()).unwrap();
    assert_eq!(alice_balance, deposit_amount + 1_000_000u128);

    // Case 2: token2.transfer_public works on its own, but withdraw fails
    // because the reward call pushes the total transitions over the limit.
    token2
        .mint_public(&alice, alice.address(), deposit_amount)
        .unwrap();
    token2
        .transfer_public(&alice, alice.address(), deposit_amount)
        .unwrap();

    vault
        .deposit(&alice, "token2".try_into().unwrap(), deposit_amount)
        .unwrap();

    let result = vault.withdraw(&alice, "token2".try_into().unwrap(), deposit_amount);
    dbg!(&result);
    assert!(result.is_err());
}
