// The 'test_token2' test program.
import token2.aleo;
program test_token2.aleo {
    @test
    @should_fail
    fn test_main_fails() {
        let result: u32 = token2.aleo::main(2u32, 3u32);
        assert_eq(result, 3u32);
    }

    @noupgrade
    constructor() {}
}
