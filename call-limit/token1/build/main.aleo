program token1.aleo;

mapping balance:
    key as address.public;
    value as u128.public;

function mint_public:
    input r0 as address.public;
    input r1 as u128.public;
    async mint_public r0 r1 into r2;
    output r2 as token1.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u128.public;
    get.or_use balance[r0] 0u128 into r2;
    add r2 r1 into r3;
    set r3 into balance[r0];

function transfer_public:
    input r0 as address.public;
    input r1 as u128.public;
    async transfer_public self.caller r1 r0 into r2;
    output r2 as token1.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as address.public;
    get.or_use balance[r0] 0u128 into r3;
    sub r3 r1 into r4;
    set r4 into balance[r0];
    get.or_use balance[r2] 0u128 into r5;
    add r5 r1 into r6;
    set r6 into balance[r2];

function transfer_public_as_signer:
    input r0 as address.public;
    input r1 as u128.public;
    async transfer_public_as_signer self.signer r1 r0 into r2;
    output r2 as token1.aleo/transfer_public_as_signer.future;

finalize transfer_public_as_signer:
    input r0 as address.public;
    input r1 as u128.public;
    input r2 as address.public;
    get.or_use balance[r0] 0u128 into r3;
    sub r3 r1 into r4;
    set r4 into balance[r0];
    get.or_use balance[r2] 0u128 into r5;
    add r5 r1 into r6;
    set r6 into balance[r2];

constructor:
    assert.eq edition 0u16;
