interface TokenStandard {
    mapping balance: address => u128;
    fn transfer_public(public recipient: address, public amount: u128) -> Final;
    fn transfer_public_as_signer(public recipient: address, public amount: u128) -> Final;
}

struct VaultAccount {
    token_program: identifier,
    user: address,
}

program vault.aleo {
    @noupgrade
    constructor() {}

    mapping account_balance: VaultAccount => u128;

    fn deposit(token_program: identifier, amount: u128) -> Final {
        let f = TokenStandard@(token_program)::transfer_public_as_signer(self.address, amount);
        let user = self.signer;
        return final {
            let account = VaultAccount {token_program: token_program, user: user};
            let b = account_balance.get_or_use(account, 0u128);
            b += amount;
            account_balance.set(account, b);
            f.run();
        };
    }

    fn withdraw(token_program: identifier, amount: u128) -> Final {
        let user = self.signer;
        let f = TokenStandard@(token_program)::transfer_public(user, amount);
        let f_reward = TokenStandard@('token1')::transfer_public(user, 1000000);
        return final {
            let account = VaultAccount {token_program: token_program, user: user};
            let b = account_balance.get(account);
            b -= amount;
            account_balance.set(account, b);
            f.run();
            let reward_balance: u128 = TokenStandard@('token1')::balance.get_or_use(self.address, 0u128);
            if reward_balance >= 1000000 {
                f_reward.run();
            }
        };
    }
}
