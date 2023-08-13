# I found this way to mock/stub at github: https://github.com/endreymarcell/spoon

setup() {
	# I always load everything
    load /test_frameworks/test_helper/bats-support/load
    load /test_frameworks/test_helper/bats-assert/load
    load /test_frameworks/test_helper/bats-file/load
    load /test_frameworks/test_helper/bats-mock/load

	export mock_date_path
	mock_date_path="$(mock_create)"

	export -f date
}

teardown() {
	export -n date
}

date() {
	bash "${mock_date_path}" "${@}"
}

@test 'Stub date so it returns a specific date' {
	mock_set_output "${mock_date_path}" "1460967598.184561556"

    run date 

    assert_output "1460967598.184561556"
}
