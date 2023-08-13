setup() {
    load /test_frameworks/test_helper/bats-support/load
    load /test_frameworks/test_helper/bats-assert/load
    load /test_frameworks/test_helper/bats-file/load
    load /test_frameworks/test_helper/bats-mock/load

	export TEST_DIR
    TEST_DIR="$( cd "$( dirname "$BATS_TEST_FILENAME" )" > /dev/null 2>&1 && pwd )"
    PATH="$TEST_DIR/../src:$PATH"
}

@test 'should have access to the script main' {
    run main.sh

    assert_output "Aloha"
}

@test 'should have access to the script touchFile' {
    
    touchFile.sh

    assert_file_exists "/tmp/someFolder/someFile"

    rm "/tmp/someFolder/someFile"
}