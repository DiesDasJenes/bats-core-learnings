setup() {
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

@test 'Stub date so its returning different values on two calls' {
	mock_set_output "${mock_date_path}" "111" 1
    mock_set_output "${mock_date_path}" "222" 2

    run date 

    assert_output "111"

    run date 

    assert_output "222"
}

@test 'Stub date so its returning different values on two calls with side effects' {
	mock_set_output "${mock_date_path}" "111" 1
    mock_set_side_effect "${mock_date_path}" "touch /tmp/someFile" 2
    mock_set_output "${mock_date_path}" "222" 3

    run date 

    assert_output "111"

    run date 

    assert_file_exists "/tmp/someFile"

    run date 

    assert_output "222"

    rm "/tmp/someFile"
}