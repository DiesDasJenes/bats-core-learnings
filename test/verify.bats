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

@test 'Verify that stub date is called with the argument' {
	mock_set_output "${mock_date_path}" "1460967598.184561556"

    date --utc 

    assert_equal "$(mock_get_call_args ${mock_date_path} 1)" "--utc"
}

@test 'Verify that stub date is called with several arguments' {
	mock_set_output "${mock_date_path}" "1460967598.184561556"

    date --utc --iso-8601

    assert_equal "$(mock_get_call_args ${mock_date_path} 1)" "--utc --iso-8601"
}

@test 'Verify that stub date is called twice' {
	mock_set_output "${mock_date_path}" "1460967598.184561556"

    date
    date

    assert_equal "$(mock_get_call_num ${mock_date_path})" 2
}