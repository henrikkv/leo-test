interface TokenStandard {
    mapping balance: address => u128;
    fn transfer_public(public recipient: address, public amount: u128) -> Final;
    fn transfer_public_as_signer(public recipient: address, public amount: u128) -> Final;
}

program token1.aleo {
    @noupgrade
    constructor() {}

    mapping balance: address => u128;

    fn mint_public(public recipient: address, public amount: u128) -> Final {
        return final {
            let b = balance.get_or_use(recipient, 0u128);
            b += amount;
            balance.set(recipient, b);
        };
    }

    fn transfer_public(public recipient: address, public amount: u128) -> Final {
        let caller = self.caller;
        return final {
            let b = balance.get_or_use(caller, 0u128);
            b -= amount;
            balance.set(caller, b);
            let r = balance.get_or_use(recipient, 0u128);
            r += amount;
            balance.set(recipient, r);
        };
    }
    fn transfer_public_as_signer(public recipient: address, public amount: u128) -> Final {
        let signer = self.signer;
        return final {
            let b = balance.get_or_use(signer, 0u128);
            b -= amount;
            balance.set(signer, b);
            let r = balance.get_or_use(recipient, 0u128);
            r += amount;
            balance.set(recipient, r);
        };
    }
}
