interface TokenStandard {
    mapping balance: address => u128;
    fn transfer_public(public recipient: address, public amount: u128) -> Final;
    fn transfer_public_as_signer(public recipient: address, public amount: u128) -> Final;
}

interface TooManyCalls {
    fn too_many_calls() -> Final;
}

interface Noop {
    fn noop() -> Final;
}

program token2.aleo {
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
        let tmc1 = TooManyCalls@('token2')::too_many_calls();
        let tmc2 = TooManyCalls@('token2')::too_many_calls();
        let f = Noop@('token2')::noop();
        return final {
            tmc1.run();
            tmc2.run();
            f.run();
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
        let tmc1 = TooManyCalls@('token2')::too_many_calls();
        let tmc2 = TooManyCalls@('token2')::too_many_calls();
        let f = Noop@('token2')::noop();
        return final {
            tmc1.run();
            tmc2.run();
            f.run();
            let b = balance.get_or_use(signer, 0u128);
            b -= amount;
            balance.set(signer, b);
            let r = balance.get_or_use(recipient, 0u128);
            r += amount;
            balance.set(recipient, r);
        };
    }

    fn too_many_calls() -> Final {
        let c01 = Noop@('token2')::noop(); let c02 = Noop@('token2')::noop();
        let c03 = Noop@('token2')::noop(); let c04 = Noop@('token2')::noop();
        let c05 = Noop@('token2')::noop(); let c06 = Noop@('token2')::noop();
        let c07 = Noop@('token2')::noop(); let c08 = Noop@('token2')::noop();
        let c09 = Noop@('token2')::noop(); let c10 = Noop@('token2')::noop();
        let c11 = Noop@('token2')::noop(); let c12 = Noop@('token2')::noop();
        let c13 = Noop@('token2')::noop();
        return final {
            c01.run(); c02.run(); c03.run(); c04.run(); c05.run(); c06.run(); c07.run();
            c08.run(); c09.run(); c10.run(); c11.run(); c12.run(); c13.run();
        };
    }

    fn noop() -> Final {
        return final {};
    }
}
