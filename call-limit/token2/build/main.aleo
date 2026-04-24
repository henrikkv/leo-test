program token2.aleo;

mapping balance:
    key as address.public;
    value as u128.public;

function mint_public:
    input r0 as address.public;
    input r1 as u128.public;
    async mint_public r0 r1 into r2;
    output r2 as token2.aleo/mint_public.future;

finalize mint_public:
    input r0 as address.public;
    input r1 as u128.public;
    get.or_use balance[r0] 0u128 into r2;
    add r2 r1 into r3;
    set r3 into balance[r0];

function transfer_public:
    input r0 as address.public;
    input r1 as u128.public;
    call.dynamic 'token2' 'aleo' 'too_many_calls' into r2 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'too_many_calls' into r3 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'noop' into r4 (as dynamic.future);
    async transfer_public r2 r3 r4 self.caller r1 r0 into r5;
    output r5 as token2.aleo/transfer_public.future;

finalize transfer_public:
    input r0 as dynamic.future;
    input r1 as dynamic.future;
    input r2 as dynamic.future;
    input r3 as address.public;
    input r4 as u128.public;
    input r5 as address.public;
    await r0;
    await r1;
    await r2;
    get.or_use balance[r3] 0u128 into r6;
    sub r6 r4 into r7;
    set r7 into balance[r3];
    get.or_use balance[r5] 0u128 into r8;
    add r8 r4 into r9;
    set r9 into balance[r5];

function transfer_public_as_signer:
    input r0 as address.public;
    input r1 as u128.public;
    call.dynamic 'token2' 'aleo' 'too_many_calls' into r2 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'too_many_calls' into r3 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'noop' into r4 (as dynamic.future);
    async transfer_public_as_signer r2 r3 r4 self.signer r1 r0 into r5;
    output r5 as token2.aleo/transfer_public_as_signer.future;

finalize transfer_public_as_signer:
    input r0 as dynamic.future;
    input r1 as dynamic.future;
    input r2 as dynamic.future;
    input r3 as address.public;
    input r4 as u128.public;
    input r5 as address.public;
    await r0;
    await r1;
    await r2;
    get.or_use balance[r3] 0u128 into r6;
    sub r6 r4 into r7;
    set r7 into balance[r3];
    get.or_use balance[r5] 0u128 into r8;
    add r8 r4 into r9;
    set r9 into balance[r5];

function too_many_calls:
    call.dynamic 'token2' 'aleo' 'noop' into r0 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'noop' into r1 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'noop' into r2 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'noop' into r3 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'noop' into r4 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'noop' into r5 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'noop' into r6 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'noop' into r7 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'noop' into r8 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'noop' into r9 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'noop' into r10 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'noop' into r11 (as dynamic.future);
    call.dynamic 'token2' 'aleo' 'noop' into r12 (as dynamic.future);
    async too_many_calls r0 r1 r2 r3 r4 r5 r6 r7 r8 r9 r10 r11 r12 into r13;
    output r13 as token2.aleo/too_many_calls.future;

finalize too_many_calls:
    input r0 as dynamic.future;
    input r1 as dynamic.future;
    input r2 as dynamic.future;
    input r3 as dynamic.future;
    input r4 as dynamic.future;
    input r5 as dynamic.future;
    input r6 as dynamic.future;
    input r7 as dynamic.future;
    input r8 as dynamic.future;
    input r9 as dynamic.future;
    input r10 as dynamic.future;
    input r11 as dynamic.future;
    input r12 as dynamic.future;
    await r0;
    await r1;
    await r2;
    await r3;
    await r4;
    await r5;
    await r6;
    await r7;
    await r8;
    await r9;
    await r10;
    await r11;
    await r12;

function noop:
    async noop into r0;
    output r0 as token2.aleo/noop.future;

finalize noop:
    assert.eq true true;

constructor:
    assert.eq edition 0u16;
