setup() {
    load /test_frameworks/test_helper/bats-support/load
    load /test_frameworks/test_helper/bats-assert/load
    load /test_frameworks/test_helper/bats-file/load
    load /test_frameworks/test_helper/bats-mock/load

	export TEST_DIR
    TEST_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" > /dev/null 2>&1 && pwd )"
    source "$TEST_DIR/../src/sum.sh"
}

@test 'should have access to the function sum' {
    run sum 1 2

    assert_output 3
}