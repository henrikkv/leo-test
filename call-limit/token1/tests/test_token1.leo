// The 'test_token1' test program.
import token1.aleo;
program test_token1.aleo {
    @test
    @should_fail
    fn test_main_fails() {
        let result: u32 = token1.aleo::main(2u32, 3u32);
        assert_eq(result, 3u32);
    }

    @noupgrade
    constructor() {}
}
