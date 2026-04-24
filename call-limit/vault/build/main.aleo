program vault.aleo;

struct VaultAccount:
    token_program as identifier;
    user as address;

mapping account_balance:
    key as VaultAccount.public;
    value as u128.public;

function deposit:
    input r0 as identifier.private;
    input r1 as u128.private;
    call.dynamic r0 'aleo' 'transfer_public_as_signer' with vault.aleo r1 (as address.public u128.public) into r2 (as dynamic.future);
    async deposit r0 self.signer r1 r2 into r3;
    output r3 as vault.aleo/deposit.future;

finalize deposit:
    input r0 as identifier.public;
    input r1 as address.public;
    input r2 as u128.public;
    input r3 as dynamic.future;
    cast r0 r1 into r4 as VaultAccount;
    get.or_use account_balance[r4] 0u128 into r5;
    add r5 r2 into r6;
    set r6 into account_balance[r4];
    await r3;

function withdraw:
    input r0 as identifier.private;
    input r1 as u128.private;
    call.dynamic r0 'aleo' 'transfer_public' with self.signer r1 (as address.public u128.public) into r2 (as dynamic.future);
    call.dynamic 'token1' 'aleo' 'transfer_public' with self.signer 1000000u128 (as address.public u128.public) into r3 (as dynamic.future);
    async withdraw r0 self.signer r1 r2 r3 into r4;
    output r4 as vault.aleo/withdraw.future;

finalize withdraw:
    input r0 as identifier.public;
    input r1 as address.public;
    input r2 as u128.public;
    input r3 as dynamic.future;
    input r4 as dynamic.future;
    cast r0 r1 into r5 as VaultAccount;
    get account_balance[r5] into r6;
    sub r6 r2 into r7;
    set r7 into account_balance[r5];
    await r3;
    get.or_use.dynamic 'token1' 'aleo' 'balance'[vault.aleo] 0u128 into r8 as u128;
    gte r8 1000000u128 into r9;
    branch.eq r9 false to end_then_0_0;
    await r4;
    branch.eq true true to end_otherwise_0_1;
    position end_then_0_0;
    position end_otherwise_0_1;

constructor:
    assert.eq edition 0u16;
